// This class provides methods to interact with the internet connectivity plugin.

import 'dart:async'; // Importing async package for Futures and Streams.
import 'package:flutter/services.dart'; // Importing services for platform channels.

class MyInternetPlugin {
  // Creating a MethodChannel to communicate with native code for method calls.
  static const MethodChannel _channel = MethodChannel('my_internet_plugin');

  // Creating an EventChannel to receive events from native code.
  static const EventChannel _eventChannel =
  EventChannel('my_internet_plugin/connectivity');

  // A Stream to listen to connectivity changes.
  static Stream<bool> get onConnectivityChanged {
    // Using receiveBroadcastStream to listen to events from the native side and map them to bool values.
    return _eventChannel.receiveBroadcastStream().map((dynamic isConnected) {
      return isConnected as bool;
    });
  }

  // Method to check internet connectivity.
  static Future<bool> checkInternet() async {
    // Invoking the native method 'checkInternet' and returning the result as a Future.
    final bool isConnected = await _channel.invokeMethod('checkInternet');
    return isConnected;
  }
}
