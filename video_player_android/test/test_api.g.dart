// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.6.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, unnecessary_import, no_leading_underscores_for_local_identifiers
// ignore_for_file: avoid_relative_lib_imports
import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;
import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:video_player_android/src/messages.g.dart';

class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    } else if (value is PlatformVideoViewType) {
      buffer.putUint8(129);
      writeValue(buffer, value.index);
    } else if (value is PlatformVideoViewCreationParams) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is CreateMessage) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129:
        final int? value = readValue(buffer) as int?;
        return value == null ? null : PlatformVideoViewType.values[value];
      case 130:
        return PlatformVideoViewCreationParams.decode(readValue(buffer)!);
      case 131:
        return CreateMessage.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class TestHostVideoPlayerApi {
  static TestDefaultBinaryMessengerBinding? get _testBinaryMessengerBinding =>
      TestDefaultBinaryMessengerBinding.instance;
  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  void initialize();

  int create(CreateMessage msg);

  void dispose(int playerId);

  void setLooping(int playerId, bool looping);

  void setVolume(int playerId, double volume);

  void setPlaybackSpeed(int playerId, double speed);

  void play(int playerId);

  int position(int playerId);

  void seekTo(int playerId, int position);

  void pause(int playerId);

  void setMixWithOthers(bool mixWithOthers);

  static void setUp(
    TestHostVideoPlayerApi? api, {
    BinaryMessenger? binaryMessenger,
    String messageChannelSuffix = '',
  }) {
    messageChannelSuffix =
        messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.initialize$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          try {
            api.initialize();
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.create$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.create was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final CreateMessage? arg_msg = (args[0] as CreateMessage?);
          assert(arg_msg != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.create was null, expected non-null CreateMessage.');
          try {
            final int output = api.create(arg_msg!);
            return <Object?>[output];
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.dispose$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.dispose was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerId = (args[0] as int?);
          assert(arg_playerId != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.dispose was null, expected non-null int.');
          try {
            api.dispose(arg_playerId!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setLooping$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setLooping was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerId = (args[0] as int?);
          assert(arg_playerId != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setLooping was null, expected non-null int.');
          final bool? arg_looping = (args[1] as bool?);
          assert(arg_looping != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setLooping was null, expected non-null bool.');
          try {
            api.setLooping(arg_playerId!, arg_looping!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setVolume$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setVolume was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerId = (args[0] as int?);
          assert(arg_playerId != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setVolume was null, expected non-null int.');
          final double? arg_volume = (args[1] as double?);
          assert(arg_volume != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setVolume was null, expected non-null double.');
          try {
            api.setVolume(arg_playerId!, arg_volume!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setPlaybackSpeed$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setPlaybackSpeed was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerId = (args[0] as int?);
          assert(arg_playerId != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setPlaybackSpeed was null, expected non-null int.');
          final double? arg_speed = (args[1] as double?);
          assert(arg_speed != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setPlaybackSpeed was null, expected non-null double.');
          try {
            api.setPlaybackSpeed(arg_playerId!, arg_speed!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.play$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.play was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerId = (args[0] as int?);
          assert(arg_playerId != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.play was null, expected non-null int.');
          try {
            api.play(arg_playerId!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.position$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.position was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerId = (args[0] as int?);
          assert(arg_playerId != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.position was null, expected non-null int.');
          try {
            final int output = api.position(arg_playerId!);
            return <Object?>[output];
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.seekTo$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.seekTo was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerId = (args[0] as int?);
          assert(arg_playerId != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.seekTo was null, expected non-null int.');
          final int? arg_position = (args[1] as int?);
          assert(arg_position != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.seekTo was null, expected non-null int.');
          try {
            api.seekTo(arg_playerId!, arg_position!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.pause$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.pause was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_playerId = (args[0] as int?);
          assert(arg_playerId != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.pause was null, expected non-null int.');
          try {
            api.pause(arg_playerId!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<
          Object?> pigeonVar_channel = BasicMessageChannel<
              Object?>(
          'dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setMixWithOthers$messageChannelSuffix',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel, null);
      } else {
        _testBinaryMessengerBinding!.defaultBinaryMessenger
            .setMockDecodedMessageHandler<Object?>(pigeonVar_channel,
                (Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setMixWithOthers was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final bool? arg_mixWithOthers = (args[0] as bool?);
          assert(arg_mixWithOthers != null,
              'Argument for dev.flutter.pigeon.video_player_android.AndroidVideoPlayerApi.setMixWithOthers was null, expected non-null bool.');
          try {
            api.setMixWithOthers(arg_mixWithOthers!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(
                error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
