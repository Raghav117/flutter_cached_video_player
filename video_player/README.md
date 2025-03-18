# flutter_cached_video

A modified version of `video_player` with caching functionality for Android.

## 📚 Features
- **Added support for video caching up to 512 MB.**
- **Implemented automatic cache management and seamless video playback.**
- **Integrated with `flutter_cached_video` to provide seamless Android support.**
- **Video caching for offline access.**
- **Same API as the original `video_player`.**

## 🚀 Getting Started
Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_cached_video: ^1.0.0
  ```

iOS

  If you need to access videos using http (rather than https) URLs, you will need to add the appropriate NSAppTransportSecurity permissions to your app's Info.plist file, located in <project root>/ios/Runner/Info.plist.

  Refer to Apple's documentation to determine the right combination of entries for your use case and supported iOS versions.

Android

  If you are using network-based videos, ensure that the following permission is present in your Android Manifest file, located in:
  ```xml
  <uses-permission android:name="android.permission.INTERNET"/>
  ```

Web
  The Web platform does not support dart:io, so avoid using the VideoPlayerController.file constructor for the plugin. Using this constructor attempts to create a VideoPlayerController.file, which will throw an UnimplementedError.

    * Different web browsers may have different video-playback capabilities (supported formats, autoplay...). Check package:video_player_web for more web-specific information.

    The VideoPlayerOptions.mixWithOthers option can't be implemented on the web at this moment. If you use this option in web, it will be silently ignored.

📹 Supported Formats

    On iOS and macOS, the backing player is AVPlayer. The supported formats vary depending on the version of iOS. The AVURLAsset class has audiovisualTypes that you can query for supported AV formats.
    On Android, the backing player is ExoPlayer. Please refer to the ExoPlayer supported formats for more information.
      On Web, available formats depend on the user's browser (vendor and version). Check package:video_player_web for specific web-related information.

📖 Example

```
import 'package:flutter/material.dart';
import 'package:flutter_cached_video/flutter_cached_video.dart';

void main() => runApp(const VideoApp());

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

🙏 Attribution

This package is based on the Flutter video_player package, which is licensed under the BSD 3-Clause License. The original copyright belongs to the Flutter Authors.

Modifications by Raghav Garg are licensed under the MIT License.