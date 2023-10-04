import 'package:flutter_test/flutter_test.dart';
import 'package:nordic_id/nordic_id.dart';
import 'package:nordic_id/nordic_id_platform_interface.dart';
import 'package:nordic_id/nordic_id_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNordicIdPlatform
    with MockPlatformInterfaceMixin
    implements NordicIdPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NordicIdPlatform initialPlatform = NordicIdPlatform.instance;

  test('$MethodChannelNordicId is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNordicId>());
  });

  test('getPlatformVersion', () async {
    NordicId nordicIdPlugin = NordicId();
    MockNordicIdPlatform fakePlatform = MockNordicIdPlatform();
    NordicIdPlatform.instance = fakePlatform;

    expect(await nordicIdPlugin.getPlatformVersion(), '42');
  });
}
