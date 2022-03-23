
import 'dart:async';

import 'package:flutter/services.dart';

enum ONELocationFrequency {
  low = ApsisOne.,
  medium,
  high
}

enum ONEConsentType {
  collectData,
  collectLocation
}

enum ONELogLevel {
  info,
  debug,
  warning,
  error,
  none
}

class ApsisOne {

  static const MethodChannel _channel = MethodChannel('apsis_one');

  static Future<void> setMinimumLogLevel(ONELogLevel level) async {
    await _channel.invokeMethod('setMinimumLogLevel', {'logLevel':level.index});
  }

  // static Future<void> provideConsent(ONEConsentType consentType) async {
  //   print(consent);
  //   await _channel.invokeMethod('provideConsent', {'consentType':consentType});
  // }

  // static Future<void> removeConsent(ONEConsentType consentType) async {
  //   await _channel.invokeMethod('removeConsent', {'consentType':consentType});
  // }

  // static Future<void> subscribeOnConsentLost(MethodCall call) async {
  //   await _channel.invokeMethod('subscribeOnConsentLost', {'methodCall':call});
  // }

  // static Future<void> startCollectingLocation(ONELocationFrequency frequency) async {
  //   await _channel.invokeMethod('startCollectingLocation', {'frequency':frequency});
  // }

  // static Future<void> stopCollectingLocation() async {
  //   await _channel.invokeMethod('stopCollectingLocation');
  // }

  // static Future<void> trackScreenViewEvent(String event) async {
  //   await _channel.invokeMethod('trackScreenViewEvent', {'event':event});
  // }

  // static Future<void> trackCustomEvent(String event, Map data) async {
  //   await _channel.invokeMethod('trackCustomEvent', {'event':event, 'data':data});
  // }

  // static Future<void> trackLocation(double latitude, double longitude, String placemarkName, String placemarAddress, int accuracy) async {
  //   await _channel.invokeMethod('trackCustomEvent', {'latitude':latitude, 'longitude':longitude, 'placemarkName':placemarkName, 'placemarAddress':placemarAddress, 'accuracy':accuracy});
  // }
}
