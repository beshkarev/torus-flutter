
import 'dart:async';

import 'package:flutter/services.dart';

class Torus {
  static const MethodChannel _channel =
      const MethodChannel('torus');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<Map<dynamic, dynamic>> triggerLogin(DirectSdkArgs args,LoginProvider loginProvider,String verifier,String clientId) async {
    try{
      var network = "MAINNET";
      if(args.network == TorusNetwork.TESTNET){
        network = "TESTNET";
      }
      return await _channel.invokeMethod('triggerLogin',{
        "redirectUri":args.redirectUri,
        "proxyContractAddress":args.proxyContractAddress,
        "browserRedirectUri":args.browserRedirectUri,
        "network":network,
        "verifier":verifier,
        "clientId":clientId,
        "loginProvider":loginProvider.value
      });


    }catch(e){
      throw e;
    }
  }

}

enum TorusNetwork {
  MAINNET,
  TESTNET
}

class DirectSdkArgs {
  String redirectUri;
  TorusNetwork network;
  String proxyContractAddress;
  String browserRedirectUri;

  DirectSdkArgs(this.redirectUri, this.network, this.proxyContractAddress,
      this.browserRedirectUri);
}

enum LoginProvider { google, facebook, twitch, reddit, discord, auth0 }

extension LoginProviderExtension on LoginProvider {
  String get value {
    switch (this) {
      case LoginProvider.google:
        return "google";
        break;
      case LoginProvider.facebook:
        return "facebook";
        break;
      case LoginProvider.auth0:
        return "auth0";
        break;
      default:
        return "google";
    }
  }
}
