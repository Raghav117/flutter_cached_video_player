package io.flutter.plugins.videoplayer;

import android.content.Context;

import androidx.media3.database.StandaloneDatabaseProvider;
import androidx.media3.datasource.cache.LeastRecentlyUsedCacheEvictor;
import androidx.media3.datasource.cache.SimpleCache;

import java.io.File;

public class SimpleCacheSingleton {
    private final LeastRecentlyUsedCacheEvictor evictor;
    private final SimpleCache simpleCache;

    private static volatile SimpleCacheSingleton instance;

    private SimpleCacheSingleton(Context context, long maxCacheSize) {
        evictor = new LeastRecentlyUsedCacheEvictor(maxCacheSize);
        File cacheDir = new File(context.getCacheDir(), "video_media");
        if (!cacheDir.exists()) {
            cacheDir.mkdirs(); // Ensure the cache directory is created
        }
        simpleCache = new SimpleCache(
                new File(cacheDir, "video_media"),
                evictor,
                new StandaloneDatabaseProvider(context)
        );
    }

    public static SimpleCacheSingleton getInstance(Context context, long maxCacheSize) {
        if (instance == null) {
            synchronized (SimpleCacheSingleton.class) {
                if (instance == null) {
                    instance = new SimpleCacheSingleton(context, maxCacheSize);
                }
            }
        }
        return instance;
    }

    public SimpleCache getCache() {
        return simpleCache;
    }
}
