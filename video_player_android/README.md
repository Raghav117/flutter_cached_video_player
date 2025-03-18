# flutter_cached_video_android

The Android implementation of `flutter_cached_video`, a modified version of the Flutter video player with built-in video caching functionality.

## 📱 Usage

This package is automatically included when you use the `flutter_cached_video` package. You do not need to add this package manually to your `pubspec.yaml`.

To enable video caching in your Flutter app, simply use the `flutter_cached_video` package. It internally utilizes `flutter_cached_video_android` to provide seamless video caching support.

## 🎥 Video Caching

The `flutter_cached_video_android` package provides the following caching features:

- **Cache Size:** Up to 512 MB of video data can be cached.
- **Automatic Cache Management:** When the cache reaches its maximum size, the oldest cached video is automatically removed to free up space for new videos.
- **Seamless Playback:** Cached videos are played seamlessly, reducing buffering and improving the user experience.

## 🚀 Getting Started

To use video caching in your Flutter app, add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_cached_video: ^1.0.0
```

Then, use the CachedVideoPlayerController to play videos with caching support:


<?code-excerpt "basic.dart (basic-example)"?>
```dart
import 'package:flutter_cached_video/flutter_cached_video.dart';

final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse("http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"));
await videoPlayerController.initialize();
videoPlayerController.play();
```

📄 License

This package is licensed under the MIT License. See the LICENSE file for details.
🙏 Attribution

This package is based on the video_player package, which is licensed under the BSD 3-Clause License. The original copyright belongs to the Flutter Authors.