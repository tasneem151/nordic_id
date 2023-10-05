import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'nordic_id_platform_interface.dart';

/// An implementation of [NordicIdPlatform] that uses method channels.
class MethodChannelNordicId extends NordicIdPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('nordic_id');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
