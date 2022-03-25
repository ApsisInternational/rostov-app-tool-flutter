
import 'dart:async';
import 'package:flutter/services.dart';
import 'apsis_one_wrapper.dart';

enum ONELocationFrequency {
  low,
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
  static ApsisOneFlutter apsisOne = ApsisOneFlutter();

  static Future<void> setMinimumLogLevel(ONELogLevel level) async {
    final int nativeLevel = getNativeLogLevel(level);
    await apsisOne.setMinimumLogLevel(nativeLevel);
  }

  static Future<void> provideConsent(ONEConsentType consentType) async {
    final int nativeConsentType = getNativeConsentType(consentType);
    await apsisOne.provideConsent(nativeConsentType);
  }

  static Future<void> removeConsent(ONEConsentType consentType) async {
    final int nativeConsentType = getNativeConsentType(consentType);
    await apsisOne.removeConsent(nativeConsentType);    
  }

  static Future<void> trackScreenViewEvent(String event) async {
    await apsisOne.trackScreenViewEvent(event);
  }

  static Future<void> trackCustomEvent(String eventId, Map data) async {
    await apsisOne.trackCustomEvent(eventId, data);
  }

  static Future<void> trackLocation(double latitude, double longitude, String placemarkName, String placemarAddress, int accuracy) async {
    await apsisOne.trackLocation(latitude, longitude, placemarkName, placemarAddress, accuracy);
  }

  static Future<void> startCollectingLocation(ONELocationFrequency frequency) async {
    final int nativeLocationFrequency = getNativeFrequency(frequency);
    await apsisOne.startCollectingLocation(nativeLocationFrequency);
  }

  static Future<void> stopCollectingLocation() async {
    await apsisOne.stopCollectingLocation();
  }

  // static Future<void> subscribeOnConsentLost(MethodCall call) async {
  //   await _channel.invokeMethod('subscribeOnConsentLost', {'methodCall':call});
  // }

  static int getNativeLogLevel(ONELogLevel level) {
    switch (level) {
      case ONELogLevel.info:
        return apsisOne.oneLogLevelInfo;
      case ONELogLevel.debug:
        return apsisOne.oneLogLevelDebug;
      case ONELogLevel.warning:
        return apsisOne.oneLogLevelWarning;
      case ONELogLevel.error:
        return apsisOne.oneLogLevelError;
      case ONELogLevel.none:
        return apsisOne.oneLogLevelNone;
    }
  }

  static int getNativeConsentType(ONEConsentType consentType) {
    switch (consentType) {
      case ONEConsentType.collectData:
        return apsisOne.oneConsentTypeCollectData;
      case ONEConsentType.collectLocation:
        return apsisOne.oneConsentTypeCollectLocation;
    }
  }

  static int getNativeFrequency(ONELocationFrequency frequency) {
    switch (frequency) {
      case ONELocationFrequency.low:
        return apsisOne.oneLocationFrequencyLow;
      case ONELocationFrequency.medium:
        return apsisOne.oneLocationFrequencyMedium;
      case ONELocationFrequency.high:
        return apsisOne.oneLocationFrequencyHigh;
    }
  }
}
