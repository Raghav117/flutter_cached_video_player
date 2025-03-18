// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.videoplayer;

import static androidx.media3.common.Player.REPEAT_MODE_ALL;
import static androidx.media3.common.Player.REPEAT_MODE_OFF;

import android.content.Context;
import android.net.Uri;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.media3.common.AudioAttributes;
import androidx.media3.common.C;
import androidx.media3.common.MediaItem;
import androidx.media3.common.PlaybackParameters;
import androidx.media3.datasource.DataSource;
import androidx.media3.datasource.DefaultDataSource;
import androidx.media3.datasource.DefaultHttpDataSource;
import androidx.media3.datasource.FileDataSource;
import androidx.media3.datasource.cache.CacheDataSink;
import androidx.media3.datasource.cache.CacheDataSource;
import androidx.media3.datasource.cache.SimpleCache;
import androidx.media3.database.DefaultDatabaseProvider;
import androidx.media3.exoplayer.ExoPlayer;
import androidx.media3.exoplayer.source.MediaSource;
import androidx.media3.exoplayer.source.ProgressiveMediaSource;
import androidx.media3.exoplayer.hls.HlsMediaSource;
import androidx.media3.exoplayer.dash.DashMediaSource;
import androidx.media3.exoplayer.smoothstreaming.SsMediaSource;
import androidx.media3.datasource.AssetDataSource;


import java.io.File;
import java.util.Map;


/**
 * A class responsible for managing video playback using {@link ExoPlayer}.
 *
 * <p>It provides methods to control playback, adjust volume, and handle seeking.
 */
public abstract class VideoPlayer {
  @NonNull private final ExoPlayerProvider exoPlayerProvider;
  @NonNull private final MediaItem mediaItem;
  @NonNull private final VideoPlayerOptions options;
  @NonNull protected final VideoPlayerCallbacks videoPlayerEvents;
  @NonNull protected ExoPlayer exoPlayer;
  @NonNull private final Context context;

  /** A closure-compatible signature since {@link java.util.function.Supplier} is API level 24. */
  public interface ExoPlayerProvider {
    /**
     * Returns a new {@link ExoPlayer}.
     *
     * @return new instance.
     */
    @NonNull
    ExoPlayer get();
  }

  public VideoPlayer(
          @NonNull Context context,
          @NonNull VideoPlayerCallbacks events,
          @NonNull MediaItem mediaItem,
          @NonNull VideoPlayerOptions options,
          @NonNull ExoPlayerProvider exoPlayerProvider) {
    this.context = context;
    this.videoPlayerEvents = events;
    this.mediaItem = mediaItem;
    this.options = options;
    this.exoPlayerProvider = exoPlayerProvider;
    this.exoPlayer = createVideoPlayer();
  }

  private DefaultHttpDataSource.Factory httpDataSourceFactory = new DefaultHttpDataSource.Factory();
  private DataSource.Factory dataSourceFactory;



  @NonNull
  protected ExoPlayer createVideoPlayer() {
    ExoPlayer exoPlayer = exoPlayerProvider.get();
    MediaSource mediaSource = buildMediaSource((mediaItem.playbackProperties.uri), null);

    exoPlayer.setMediaSource(mediaSource);
    exoPlayer.prepare();

    exoPlayer.addListener(createExoPlayerEventListener(exoPlayer));
    setAudioAttributes(exoPlayer, options.mixWithOthers);

    return exoPlayer;
  }

  private DataSource.Factory buildHttpDataSourceFactory() {
    httpDataSourceFactory.setUserAgent("ExoPlayer").setAllowCrossProtocolRedirects(true);
    return httpDataSourceFactory;
  }

  private MediaSource buildMediaSource(Uri uri, String formatHint) {
    String scheme = uri.getScheme();
    if (scheme == null) {
      // If no scheme, assume it's an asset
      dataSourceFactory = new DataSource.Factory() {
        @Override
        public DataSource createDataSource() {
          return new AssetDataSource(context);
        }
      };
    } else if (scheme.equals("asset")) {
      // Asset file (e.g., asset:///video.mp4)
      dataSourceFactory = new DataSource.Factory() {
        @Override
        public DataSource createDataSource() {
          return new AssetDataSource(context);
        }
      };
    } else if (scheme.equals("file")) {
      // Local storage file (e.g., file:///storage/emulated/0/Download/video.mp4)
      dataSourceFactory = new FileDataSource.Factory();
    } else if (scheme.equals("http") || scheme.equals("https")) {
      // Network source
      dataSourceFactory = buildCacheDataSourceFactory();
    } else {
      // Default case (use standard DataSource)
      dataSourceFactory = new DefaultDataSource.Factory(context);
    }

    MediaItem mediaItem = MediaItem.fromUri(uri);


    // Validate the URI
    if (uri == null || uri.toString().isEmpty()) {
      throw new IllegalArgumentException("Invalid or empty URI");
    }
    if (uri.toString().endsWith(".m3u8")) {
      return new HlsMediaSource.Factory(dataSourceFactory).createMediaSource(mediaItem);
    } else if (uri.toString().endsWith(".mpd")) {
      return new DashMediaSource.Factory(dataSourceFactory).createMediaSource(mediaItem);
    } else if (uri.toString().endsWith(".ism") || uri.toString().endsWith(".isml")) {
      return new SsMediaSource.Factory(dataSourceFactory).createMediaSource(mediaItem);
    } else {
      return new ProgressiveMediaSource.Factory(dataSourceFactory).createMediaSource(mediaItem);
    }
  }


  private DataSource.Factory buildCacheDataSourceFactory() {
    SimpleCache cache = SimpleCacheSingleton.getInstance(context, 1024 * 1024 * 512).getCache();

    CacheDataSink.Factory cacheSink = new CacheDataSink.Factory()
            .setCache(cache)
            .setFragmentSize(CacheDataSink.DEFAULT_FRAGMENT_SIZE);

    DefaultDataSource.Factory upstreamFactory = new DefaultDataSource.Factory(context, buildHttpDataSourceFactory());
    FileDataSource.Factory cacheReadDataSourceFactory = new FileDataSource.Factory();

    return new CacheDataSource.Factory()
            .setCache(cache)
            .setCacheWriteDataSinkFactory(cacheSink)
            .setCacheReadDataSourceFactory(cacheReadDataSourceFactory)
            .setUpstreamDataSourceFactory(upstreamFactory)
            .setFlags(CacheDataSource.FLAG_IGNORE_CACHE_ON_ERROR);
  }

  @NonNull
  protected abstract ExoPlayerEventListener createExoPlayerEventListener(
      @NonNull ExoPlayer exoPlayer);

  void sendBufferingUpdate() {
    videoPlayerEvents.onBufferingUpdate(exoPlayer.getBufferedPosition());
  }

  private static void setAudioAttributes(ExoPlayer exoPlayer, boolean isMixMode) {
    exoPlayer.setAudioAttributes(
        new AudioAttributes.Builder().setContentType(C.AUDIO_CONTENT_TYPE_MOVIE).build(),
        !isMixMode);
  }

  void play() {
    exoPlayer.play();
  }

  void pause() {
    exoPlayer.pause();
  }

  void setLooping(boolean value) {
    exoPlayer.setRepeatMode(value ? REPEAT_MODE_ALL : REPEAT_MODE_OFF);
  }

  void setVolume(double value) {
    float bracketedValue = (float) Math.max(0.0, Math.min(1.0, value));
    exoPlayer.setVolume(bracketedValue);
  }

  void setPlaybackSpeed(double value) {
    // We do not need to consider pitch and skipSilence for now as we do not handle them and
    // therefore never diverge from the default values.
    final PlaybackParameters playbackParameters = new PlaybackParameters(((float) value));

    exoPlayer.setPlaybackParameters(playbackParameters);
  }

  void seekTo(int location) {
    exoPlayer.seekTo(location);
  }

  long getPosition() {
    return exoPlayer.getCurrentPosition();
  }

  @NonNull
  public ExoPlayer getExoPlayer() {
    return exoPlayer;
  }

  public void dispose() {
    exoPlayer.release();
  }
}
