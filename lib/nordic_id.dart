
import 'nordic_id_platform_interface.dart';

class NordicId {
  Future<String?> getPlatformVersion() {
    return NordicIdPlatform.instance.getPlatformVersion();
  }
}
