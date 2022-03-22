#import "ApsisOnePlugin.h"
#if __has_include(<apsis_one/apsis_one-Swift.h>)
#import <apsis_one/apsis_one-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "apsis_one-Swift.h"
#endif

@implementation ApsisOnePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftApsisOnePlugin registerWithRegistrar:registrar];
}
@end
