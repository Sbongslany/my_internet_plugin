// This code creates a Flutter app to check internet connectivity using the MyInternetPlugin.
import 'package:flutter/material.dart';
import 'package:my_internet_plugin/my_internet_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Boolean variable to track internet connectivity status.
  bool _isConnected = false;

  // initState method, called when this object is inserted into the tree.
  @override
  void initState() {
    super.initState();
    // Listening to connectivity changes using the onConnectivityChanged stream.
    MyInternetPlugin.onConnectivityChanged.listen((bool isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Internet Connectivity'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Internet Connectivity: $_isConnected'), // Text widget to display internet connectivity status.
              ElevatedButton(

                onPressed: () async {
                  // onPressed callback function when the button is pressed.
                  bool isConnected =
                  await MyInternetPlugin.checkInternet(); // Checking internet connectivity.
                  setState(() {
                    // Updating the UI with the new connectivity status.
                    _isConnected = isConnected;
                  });
                },
                child: const Text('Check Connectivity'), // Text displayed on the button.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
