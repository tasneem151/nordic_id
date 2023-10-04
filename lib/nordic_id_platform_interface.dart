import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'nordic_id_method_channel.dart';

abstract class NordicIdPlatform extends PlatformInterface {
  /// Constructs a NordicIdPlatform.
  NordicIdPlatform() : super(token: _token);

  static final Object _token = Object();

  static NordicIdPlatform _instance = MethodChannelNordicId();

  /// The default instance of [NordicIdPlatform] to use.
  ///
  /// Defaults to [MethodChannelNordicId].
  static NordicIdPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NordicIdPlatform] when
  /// they register themselves.
  static set instance(NordicIdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
