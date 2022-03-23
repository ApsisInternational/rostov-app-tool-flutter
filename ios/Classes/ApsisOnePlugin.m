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
    FlutterMethodChannel* apsisOneChannel = [FlutterMethodChannel methodChannelWithName:@"apsis_one"
                                                                       binaryMessenger:[registrar messenger]];
    ApsisOnePlugin *instance = ApsisOnePlugin.new;
    [registrar addMethodCallDelegate:instance channel:apsisOneChannel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSLog(@"Method was called: %@", call.method);
    if ([call.method isEqualToString:@"setMinimumLogLevel"]) {
      ONELogLevel logLevel = call.arguments[@"logLevel"];
      [ApsisOneAPI setMinimumLogLevel:logLevel];
      result(nil);
    } else if([call.method isEqualToString:@"provideConsent"]) {
      ONEConsentType consentType = call.arguments[@"consentType"];
      [ApsisOneAPI provideConsent:consentType];
      result(nil);
    } else if([call.method isEqualToString:@"removeConsent"]) {

    } else if([call.method isEqualToString:@"subscribeOnConsentLost"]) {

    } else if([call.method isEqualToString:@"startCollectingLocation"]) {

    } else if([call.method isEqualToString:@"stopCollectingLocation"]) {

    } else if([call.method isEqualToString:@"trackScreenViewEvent"]) {

    } else if([call.method isEqualToString:@"trackCustomEvent"]) {

    } else if([call.method isEqualToString:@"trackCustomEvent"]) {

    } else {
      result(FlutterMethodNotImplemented);
    }
}

// RCT_EXPORT_METHOD(provideConsent:(ONEConsentType)consentType) {
//     [ApsisOneAPI provideConsent:consentType];
// }

// RCT_EXPORT_METHOD(removeConsent:(ONEConsentType)consentType) {
//     [ApsisOneAPI removeConsent:consentType];
// }

// RCT_EXPORT_METHOD(subscribeCollectDataConsentLost:(RCTResponseSenderBlock)consentLostHandler) {
//     [ApsisOneAPI subscribeOnConsentLost:^(ONEConsentType consentType) {
//         if (consentType == ONEConsentTypeCollectData) {
//             consentLostHandler(@[]);
//         }
//     }];
// }

// RCT_EXPORT_METHOD(trackScreenViewEvent:(NSString *)event) {
//     ONEScreenViewEvent *screenViewEvent = [ONEScreenViewEvent eventWithViewName:event
//                                                                       className:@"RNView"];
//     [ApsisOneAPI trackScreenViewEvent:screenViewEvent];
// }

// RCT_EXPORT_METHOD(trackCustomEvent:(NSString *)eventId data:(NSString *)eventData) {
//     NSData *jsonData = [eventData dataUsingEncoding:NSUTF8StringEncoding];
//     NSError *error;
//     NSDictionary *data = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                          options:NSJSONReadingAllowFragments
//                                                            error:&error];
    
//     if (error) {
//         return;
//     }
//     ONECustomEvent *event = [ONECustomEvent eventWithId:eventId data:data];
//     [ApsisOneAPI trackCustomEvent:event];
// }

// RCT_EXPORT_METHOD(setMinimumLogLevel:(ONELogLevel)level) {
//     [ApsisOneAPI setMinimumLogLevel:level];
// }

// RCT_EXPORT_METHOD(startCollectingLocation:(ONELocationFrequency)frequency) {
//     [ApsisOneAPI startCollectingLocation:frequency];
// }

// RCT_EXPORT_METHOD(stopCollectingLocation) {
//     [ApsisOneAPI stopCollectingLocation];
// }

// RCT_EXPORT_METHOD(trackLocation:(double)latitude longitude:(double)longitude placemark:(NSString *)placemark address:(NSString *)address accuracy:(NSUInteger)accuracy) {
//     ONEPlacemark *onePlacemark = [ONEPlacemark placemarkWithName:placemark
//                                                          address:address];
//     [ApsisOneAPI trackLocationWithLatitude:latitude
//                                  longitude:longitude
//                                  placemark:onePlacemark
//                         horizontalAccuracy:accuracy];
// }

@end
