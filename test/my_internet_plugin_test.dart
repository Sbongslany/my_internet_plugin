import 'package:flutter_test/flutter_test.dart';
import 'package:my_internet_plugin/my_internet_plugin.dart';
import 'package:my_internet_plugin/my_internet_plugin_platform_interface.dart';
import 'package:my_internet_plugin/my_internet_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMyInternetPluginPlatform
    with MockPlatformInterfaceMixin
    implements MyInternetPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MyInternetPluginPlatform initialPlatform = MyInternetPluginPlatform.instance;

  test('$MethodChannelMyInternetPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMyInternetPlugin>());
  });

  test('getPlatformVersion', () async {
    MyInternetPlugin myInternetPlugin = MyInternetPlugin();
    MockMyInternetPluginPlatform fakePlatform = MockMyInternetPluginPlatform();
    MyInternetPluginPlatform.instance = fakePlatform;

    expect(await myInternetPlugin.getPlatformVersion(), '42');
  });
}
