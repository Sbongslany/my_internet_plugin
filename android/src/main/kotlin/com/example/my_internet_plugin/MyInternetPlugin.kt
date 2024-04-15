package com.example.my_internet_plugin

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.content.Context
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest

class MyInternetPlugin private constructor(context: Context, messenger: BinaryMessenger) : MethodChannel.MethodCallHandler {
  private val context: Context
  private val connectivityManager: ConnectivityManager
  private var eventSink: EventChannel.EventSink? = null

  init {
    this.context = context
    connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
    val eventChannel = EventChannel(messenger, "my_internet_plugin/connectivity")
    eventChannel.setStreamHandler(object : StreamHandler() {
      @Override
      fun onListen(arguments: Object?, sink: EventChannel.EventSink?) {
        eventSink = sink
        startListening()
      }

      @Override
      fun onCancel(arguments: Object?) {
        stopListening()
      }
    })
  }

  @Override
  fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method.equals("checkInternet")) {
      val isConnected = checkInternetConnection()
      result.success(isConnected)
    } else {
      result.notImplemented()
    }
  }

  private fun startListening() {
    val networkCallback: ConnectivityManager.NetworkCallback = object : NetworkCallback() {
      @Override
      fun onAvailable(network: Network?) {
        super.onAvailable(network)
        if (eventSink != null) {
          eventSink.success(true)
        }
      }

      @Override
      fun onLost(network: Network?) {
        super.onLost(network)
        if (eventSink != null) {
          eventSink.success(false)
        }
      }
    }
    val builder: NetworkRequest.Builder = Builder()
    connectivityManager.registerNetworkCallback(builder.build(), networkCallback)
  }

  private fun stopListening() {
    connectivityManager.unregisterNetworkCallback(NetworkCallback())
  }

  private fun checkInternetConnection(): Boolean {
    val capabilities: NetworkCapabilities = connectivityManager.getNetworkCapabilities(connectivityManager.getActiveNetwork())
    return capabilities != null && (capabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) || capabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR))
  }

  companion object {
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "my_internet_plugin")
      val instance = MyInternetPlugin(registrar.context(), registrar.messenger())
      channel.setMethodCallHandler(instance)
    }
  }
}