import Flutter
import UIKit
import TorusSwiftDirectSDK

public class SwiftTorusPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "torus", binaryMessenger: registrar.messenger())
    let instance = SwiftTorusPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "triggerLogin" {

      guard let args = call.arguments as? [String: Any] else {
        result("iOS could not recognize flutter arguments in method: (sendParams)")
        return
      }
        if let myArgs = args as? [String: Any],
           let redirectUri = myArgs["redirectUri"] as? String,
            let clientId = myArgs["clientId"] as? String,
            let loginProvider = myArgs["loginProvider"] as? String,
            let verifier = myArgs["verifier"] as? String{
          let sub = SubVerifierDetails(loginType: .installed, // default .web
            loginProvider: LoginProviders(rawValue: loginProvider)!,
                                    clientId:clientId,
                                    verifierName: verifier,
                                    redirectURL: redirectUri)
          if #available(iOS 11.0, *) {
              let tdsdk = TorusSwiftDirectSDK(aggregateVerifierType: .singleLogin, aggregateVerifierName: verifier, subVerifierDetails: [sub])
            let rootViewController:UIViewController! = UIApplication.shared.keyWindow?.rootViewController
              // controller is used to present a SFSafariViewController.
              tdsdk.triggerLogin(controller: rootViewController).done{ data in
                  result(data)
              }.catch{ err in
                result(FlutterError(code: "-1", message: "Error"+err, details: nil))
              }
          } else {
              result(FlutterError(code: "-1", message: "plugin not supported in this ios versions", details: nil))
          }
        } else {
          result(FlutterError(code: "-1", message: "kindly send all the required params", details: nil))
        }
        

      
    } else {
      result("Flutter method not implemented on iOS")
    }
  }
}
