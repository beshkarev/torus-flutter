import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:torus/torus.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: MaterialButton(
            onPressed: () async{
              var args = DirectSdkArgs(
                  "torusapp://org.torusresearch.torusdirectandroid/redirect",
                  TorusNetwork.TESTNET, "0x4023d2a0D330bF11426B12C6144Cfb96B7fa6183",
                  "torusapp://org.torusresearch.torusdirectandroid/redirect"
              );
              var result = await Torus.triggerLogin(args,LoginProvider.google,"google","221898609709-obfn3p63741l5333093430j3qeiinaa8.apps.googleusercontent.com");
              print(result);
            },
            child: Text("Launch"),
          ),
        ),
      ),
    );
  }
}
