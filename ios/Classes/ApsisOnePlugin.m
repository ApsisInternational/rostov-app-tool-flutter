#import "ApsisOnePlugin.h"
#if __has_include(<apsis_one/apsis_one-Swift.h>)
#import <apsis_one/apsis_one-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "apsis_one-Swift.h"
#endif

@interface ApsisOnePlugin() <FlutterStreamHandler>

@property (strong, nonatomic) FlutterMethodChannel *apsisOneMethodChannel;
@property (strong, nonatomic) FlutterEventChannel *apsisOneEventChannel;
@property (nonatomic) FlutterEventSink eventSink;

@end


@implementation ApsisOnePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    ApsisOnePlugin *instance = ApsisOnePlugin.new;
    instance.apsisOneMethodChannel = [FlutterMethodChannel methodChannelWithName:@"com.apsis.one/publicapi"
                                                       binaryMessenger:[registrar messenger]];
    instance.apsisOneEventChannel = [FlutterEventChannel eventChannelWithName:@"com.apsis.one/consents"
                                                              binaryMessenger:[registrar messenger]];
    [registrar addMethodCallDelegate:instance
                             channel:instance.apsisOneMethodChannel];
    [instance.apsisOneEventChannel setStreamHandler:instance];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
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
        [ApsisOneAPI subscribeOnConsentLost:^(ONEConsentType consentType) {
            if (consentType == ONEConsentTypeCollectData) {
                self.eventSink(@(consentType));
            }
        }];
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

- (FlutterError *)onCancelWithArguments:(id)arguments {
    self.eventSink = nil;
    return nil;
}

- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events {
    self.eventSink = events;
    return nil;
}

@end
