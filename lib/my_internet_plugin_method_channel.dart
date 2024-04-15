import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_internet_plugin_platform_interface.dart';

/// An implementation of [MyInternetPluginPlatform] that uses method channels.
class MethodChannelMyInternetPlugin extends MyInternetPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_internet_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
