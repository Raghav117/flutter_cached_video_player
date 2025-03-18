package io.flutter.plugins.videoplayer.platformview;

import android.content.Context;
import androidx.annotation.NonNull;
import androidx.annotation.VisibleForTesting;
import androidx.media3.common.MediaItem;
import androidx.media3.exoplayer.ExoPlayer;
import io.flutter.plugins.videoplayer.ExoPlayerEventListener;
import io.flutter.plugins.videoplayer.VideoAsset;
import io.flutter.plugins.videoplayer.VideoPlayer;
import io.flutter.plugins.videoplayer.VideoPlayerCallbacks;
import io.flutter.plugins.videoplayer.VideoPlayerOptions;

/**
 * A subclass of {@link VideoPlayer} that adds functionality related to platform view as a way of
 * displaying the video in the app.
 */

// Copyright 2013 The Flutter Authors. All rights reserved.
// Copyright 2025 Raghav Garg. All rights reserved.
//
// Use of this source code is governed by a BSD-style license that can be
// found in the ORIGINAL_LICENSE file.
//
// Modifications by Raghav Garg are licensed under the MIT License.
// See the LICENSE file for details.

public class PlatformViewVideoPlayer extends VideoPlayer {
  @VisibleForTesting
  public PlatformViewVideoPlayer(
          @NonNull Context context,
          @NonNull VideoPlayerCallbacks events,
          @NonNull MediaItem mediaItem,
          @NonNull VideoPlayerOptions options,
          @NonNull ExoPlayerProvider exoPlayerProvider) {
    super(context, events, mediaItem, options, exoPlayerProvider); // Correct parameter order
  }

  /**
   * Creates a platform view video player.
   *
   * @param context application context.
   * @param events event callbacks.
   * @param asset asset to play.
   * @param options options for playback.
   * @return a video player instance.
   */
  @NonNull
  public static PlatformViewVideoPlayer create(
          @NonNull Context context,
          @NonNull VideoPlayerCallbacks events,
          @NonNull VideoAsset asset,
          @NonNull VideoPlayerOptions options) {
    return new PlatformViewVideoPlayer(
            context, // Pass context first
            events,
            asset.getMediaItem(),
            options,
            () -> {
              ExoPlayer.Builder builder =
                      new ExoPlayer.Builder(context)
                              .setMediaSourceFactory(asset.getMediaSourceFactory(context));
              return builder.build();
            });
  }

  @NonNull
  @Override
  protected ExoPlayerEventListener createExoPlayerEventListener(@NonNull ExoPlayer exoPlayer) {
    // Platform view video player does not suspend and re-create the exoPlayer, hence initialized
    // is always false.
    return new PlatformViewExoPlayerEventListener(exoPlayer, videoPlayerEvents, false);
  }
}