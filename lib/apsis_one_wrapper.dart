import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/widgets.dart';
import 'apsis_one_wrapper_android_imp.dart';
import 'apsis_one_wrapper_ios_imp.dart';

abstract class ApsisOneFlutter {
  int get oneLocationFrequencyLow;
  int get oneLocationFrequencyMedium;
  int get oneLocationFrequencyHigh;
  int get oneConsentTypeCollectData;
  int get oneConsentTypeCollectLocation;
  int get oneLogLevelInfo;
  int get oneLogLevelDebug;
  int get oneLogLevelWarning;
  int get oneLogLevelError;
  int get oneLogLevelNone;

  Future<void> setMinimumLogLevel(int level);
  Future<void> provideConsent(int consentType);
  Future<void> removeConsent(int consentType);
  Future<void> subscribeOnConsentLost(Future<dynamic> handler(int consentType));
  Future<void> startCollectingLocation(int frequency);
  Future<void> stopCollectingLocation();
  Future<void> trackScreenViewEvent(String event);
  Future<void> trackCustomEvent(String eventId, Map data);
  Future<void> trackLocation(double latitude, double longitude,
      String placemarkName, String placemarAddress, int accuracy);
  Widget contextualMessageView(String messageId);

  factory ApsisOneFlutter() {
    if (Platform.isAndroid) {
      return ApsisOneAndroid_Imp();
    }
    return ApsisOneIOS_Imp();
  }
}
