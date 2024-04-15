import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_internet_plugin_method_channel.dart';

abstract class MyInternetPluginPlatform extends PlatformInterface {
  /// Constructs a MyInternetPluginPlatform.
  MyInternetPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyInternetPluginPlatform _instance = MethodChannelMyInternetPlugin();

  /// The default instance of [MyInternetPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyInternetPlugin].
  static MyInternetPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyInternetPluginPlatform] when
  /// they register themselves.
  static set instance(MyInternetPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
