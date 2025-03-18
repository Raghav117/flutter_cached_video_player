<?code-excerpt path-base="example/lib"?>

# flutter_cached_video_player

A modified version of `video_player` with caching functionality for Android.

## 📚 Features
- Video caching for offline access.
- Same API as the original `video_player`.

## 🚀 Getting Started
Add the package to your `pubspec.yaml`:
```yaml

dependencies:
  flutter_cached_video_player: ^1.0.0


## Setup

### iOS

If you need to access videos using `http` (rather than `https`) URLs, you will need to add
the appropriate `NSAppTransportSecurity` permissions to your app's _Info.plist_ file, located
in `<project root>/ios/Runner/Info.plist`. See
[Apple's documentation](https://developer.apple.com/documentation/bundleresources/information_property_list/nsapptransportsecurity)
to determine the right combination of entries for your use case and supported iOS versions.

### Android

If you are using network-based videos, ensure that the following permission is present in your
Android Manifest file, located in `<project root>/android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

### macOS

If you are using network-based videos, you will need to [add the
`com.apple.security.network.client`
entitlement](https://flutter.dev/to/macos-entitlements)

### Web

> The Web platform does **not** support `dart:io`, so avoid using the `VideoPlayerController.file` constructor for the plugin. Using the constructor attempts to create a `VideoPlayerController.file` that will throw an `UnimplementedError`.

\* Different web browsers may have different video-playback capabilities (supported formats, autoplay...). Check [package:video_player_web](https://pub.dev/packages/video_player_web) for more web-specific information.

The `VideoPlayerOptions.mixWithOthers` option can't be implemented in web, at least at the moment. If you use this option in web it will be silently ignored.

## Supported Formats

- On iOS and macOS, the backing player is [AVPlayer](https://developer.apple.com/documentation/avfoundation/avplayer).
  The supported formats vary depending on the version of iOS, [AVURLAsset](https://developer.apple.com/documentation/avfoundation/avurlasset) class
  has [audiovisualTypes](https://developer.apple.com/documentation/avfoundation/avurlasset/1386800-audiovisualtypes?language=objc) that you can query for supported av formats.
- On Android, the backing player is [ExoPlayer](https://google.github.io/ExoPlayer/),
  please refer [here](https://google.github.io/ExoPlayer/supported-formats.html) for list of supported formats.
- On Web, available formats depend on your users' browsers (vendor and version). Check [package:video_player_web](https://pub.dev/packages/video_player_web) for more specific information.

## Example

<?code-excerpt "basic.dart (basic-example)"?>
```dart
import 'package:flutter/material.dart';
import 'package:flutter_cached_video_player/video_player.dart';

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
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
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

## Attribution
This package is based on the Flutter [`video_player`](https://github.com/flutter/packages/tree/main/packages/video_player) package, which is licensed under the BSD 3-Clause License. The original copyright belongs to the Flutter Authors.

Modifications by Raghav Garg are licensed under the [MIT License](LICENSE).
