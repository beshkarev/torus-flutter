#import "TorusPlugin.h"
#if __has_include(<torus/torus-Swift.h>)
#import <torus/torus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "torus-Swift.h"
#endif

@implementation TorusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTorusPlugin registerWithRegistrar:registrar];
}
@end
