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
    NSLog(@"Method was called: %@ with args %@", call.method, call.arguments);
    
    if ([call.method isEqualToString:@"setMinimumLogLevel"]) {
        ONELogLevel logLevel = (ONELogLevel)[call.arguments[@"logLevel"] intValue];
        [ApsisOneAPI setMinimumLogLevel:logLevel];
        result(nil);
    } else if([call.method isEqualToString:@"provideConsent"]) {
        ONEConsentType consentType = (ONEConsentType)[call.arguments[@"consentType"] intValue];
        [ApsisOneAPI provideConsent:consentType];
        result(nil);
    } else if([call.method isEqualToString:@"removeConsent"]) {
        ONEConsentType consentType = (ONEConsentType)[call.arguments[@"consentType"] intValue];
        [ApsisOneAPI removeConsent:consentType];
        result(nil);
    } else if([call.method isEqualToString:@"subscribeOnConsentLost"]) {
        
    } else if([call.method isEqualToString:@"startCollectingLocation"]) {
        ONELocationFrequency locationFrequency = (ONELocationFrequency)[call.arguments[@"frequency"] intValue];
        [ApsisOneAPI startCollectingLocation:locationFrequency];
    } else if([call.method isEqualToString:@"stopCollectingLocation"]) {
        [ApsisOneAPI stopCollectingLocation];
    } else if([call.method isEqualToString:@"trackScreenViewEvent"]) {
        NSString *screenName = call.arguments[@"event"];
        ONEScreenViewEvent *screenViewEvent = [ONEScreenViewEvent eventWithViewName:screenName
                                                                          className:@"FlutterView"];
        [ApsisOneAPI trackScreenViewEvent:screenViewEvent];
    } else if([call.method isEqualToString:@"trackCustomEvent"]) {
        NSString *eventId = call.arguments[@"eventId"];
        NSDictionary *eventData = call.arguments[@"data"];
        ONECustomEvent *customEvent = [ONECustomEvent eventWithId:eventId
                                                             data:eventData];
        [ApsisOneAPI trackCustomEvent:customEvent];
    } else if([call.method isEqualToString:@"trackLocation"]) {
        double latitude = [call.arguments[@"latitude"] doubleValue];
        double longitude = [call.arguments[@"longitude"] doubleValue];
        ONEPlacemark *placemark = [ONEPlacemark placemarkWithName:call.arguments[@"placemarkName"]
                                                          address:call.arguments[@"placemarkAddress"]];
        NSUInteger accuracy = [call.arguments[@"accuracy"] unsignedIntegerValue];
        [ApsisOneAPI trackLocationWithLatitude:latitude longitude:longitude placemark:placemark horizontalAccuracy:accuracy];
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
