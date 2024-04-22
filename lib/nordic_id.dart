import 'package:flutter/services.dart';

//import 'nordic_id_platform_interface.dart';

class NordicId {
  static const _channel = MethodChannel('nordic_id');

/*   Future<String?> getPlatformVersion() {
    return NordicIdPlatform.instance.getPlatformVersion();
  }
 */

  static Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  static const EventChannel tagsStatusStream = EventChannel('TagsStatus');
  static const EventChannel connectionStatusStream =
      EventChannel('ConnectionStatus');

  static const EventChannel connectionDetailsStream =
      EventChannel('ConnectionDetails');

  static Future<bool?> get initialize async {
    return _channel.invokeMethod('Initialize');
  }

  static Future<bool?> get connect async {
    return _channel.invokeMethod('Connect');
  }

  static Future<bool?> get connectUsb async {
    return _channel.invokeMethod('ConnectUsb');
  }

  // static Future<bool?> deviceName() async {
  //   return _channel.invokeMethod('DeviceName');
  // }

  static Future<bool?> get read async {
    return _channel.invokeMethod('Read');
  }

  static Future<bool?> get startInventoryStream async {
    return _channel.invokeMethod('StartInventoryStream');
  }

  static Future<bool?> get stopInventoryStream async {
    return _channel.invokeMethod('StopInventoryStream');
  }

  static Future<bool?> get isConnected async {
    return _channel.invokeMethod('IsConnected');
  }

  static Future<bool?> get destroy async {
    return _channel.invokeMethod('Destroy');
  }

  static Future<bool?> get stopTrace async {
    return _channel.invokeMethod('StopTrace');
  }

  static Future<bool?> get reset async {
    return _channel.invokeMethod('Reset');
  }

  static Future<String?> get powerOff async {
    return _channel.invokeMethod('PowerOff');
  }

  static Future<bool?> get refreshTracing async {
    return _channel.invokeMethod('RefreshTracing');
  }

  /* static Future<bool?> setWorkArea(String value) async {
    return _channel
        .invokeMethod('setWorkArea', <String, String>{'value': value});
  } */
}
