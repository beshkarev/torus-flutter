# Torus Direct 
    A torus direct flutter plugin supports both android and ios.
### Android Setup

Add following activity to your manifest file,

```sh
<activity android:name="org.torusresearch.torusdirect.activity.StartUpActivity"
    android:launchMode="singleTop"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"
    >
    <intent-filter>
        <action android:name="android.intent.action.VIEW"/>
        <category android:name="android.intent.category.DEFAULT"/>
        <category android:name="android.intent.category.BROWSABLE"/>
        <data android:scheme="torusapp"
            android:host="org.torusresearch.torusdirectandroid"
            android:pathPattern="/*"
            android:pathPrefix="/redirect"/>
    </intent-filter>
</activity>
```
### iOS Setup

Add below lines to your AppDelegate.swift file,

```sh
override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.host == "your host" {
            TorusSwiftDirectSDK.handle(url: url)
        }
        return true
    }
```

### Usage


```sh
 var args = DirectSdkArgs(
                  "torusapp://org.torusresearch.torusdirectandroid/redirect", //redirectUri
                  TorusNetwork.TESTNET, //network
                  "0x4023d2a0D330bF11426B12C6144Cfb96B7fa6183", //proxyContractAddress
                  "torusapp://org.torusresearch.torusdirectandroid/redirect" //browserRedirectUri
              );
await Torus.triggerLogin(
    args, // DirectSdkArgs
    LoginProvider.google, // LoginProvider
    "google", //Verifier
    "221898609709-obfn3p63741l5333093430j3qeiinaa8.apps.googleusercontent.com" //client Id
);
```


