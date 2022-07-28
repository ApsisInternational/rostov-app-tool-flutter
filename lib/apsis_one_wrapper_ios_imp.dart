import 'package:apsis_one/ios_virtual_display_view.dart';
import 'package:flutter/widgets.dart';
import 'apsis_one_wrapper.dart';
import 'package:flutter/services.dart';

class ApsisOneIOS_Imp implements ApsisOneFlutter {
  final MethodChannel _channel = const MethodChannel('com.apsis.one/publicapi');
  final EventChannel _eventChannel =
      const EventChannel('com.apsis.one/consents');

  @override
  Future<void> setMinimumLogLevel(int level) async {
    await _channel.invokeMethod('setMinimumLogLevel', {'logLevel': level});
  }

  @override
  Future<void> provideConsent(int consentType) async {
    await _channel.invokeMethod('provideConsent', {'consentType': consentType});
  }

  @override
  Future<void> removeConsent(int consentType) async {
    await _channel.invokeMethod('removeConsent', {'consentType': consentType});
  }

  @override
  Future<void> trackScreenViewEvent(String event) async {
    await _channel.invokeMethod('trackScreenViewEvent', {'event': event});
  }

  @override
  Future<void> trackCustomEvent(String eventId, Map data) async {
    await _channel
        .invokeMethod('trackCustomEvent', {'eventId': eventId, 'data': data});
  }

  @override
  Future<void> trackLocation(double latitude, double longitude,
      String placemarkName, String placemarAddress, int accuracy) async {
    await _channel.invokeMethod('trackLocation', {
      'latitude': latitude,
      'longitude': longitude,
      'placemarkName': placemarkName,
      'placemarAddress': placemarAddress,
      'accuracy': accuracy
    });
  }

  @override
  Future<void> startCollectingLocation(int frequency) async {
    await _channel
        .invokeMethod('startCollectingLocation', {'frequency': frequency});
  }

  @override
  Future<void> stopCollectingLocation() async {
    await _channel.invokeMethod('stopCollectingLocation');
  }

  @override
  Future<void> subscribeOnConsentLost(
      Future<dynamic> handler(int consentType)) async {
    consentLostHandler(dynamic event) {
      handler(event);
    }

    consentLostErrorHandler(dynamic error) =>
        print('Received error: ${error.message}');
    _eventChannel
        .receiveBroadcastStream()
        .listen(consentLostHandler, onError: consentLostErrorHandler);
    await _channel.invokeMethod(
        'subscribeOnConsentLost', {'consentType': oneConsentTypeCollectData});
  }

  @override
  Widget contextualMessageView(String messageId) {
    return IOSVirtualDisplayView(messageId: messageId);
  }

  @override
  int get oneLocationFrequencyLow => 1;
  @override
  int get oneLocationFrequencyMedium => 2;
  @override
  int get oneLocationFrequencyHigh => 3;
  @override
  int get oneConsentTypeCollectData => 1;
  @override
  int get oneConsentTypeCollectLocation => 2;
  @override
  int get oneLogLevelInfo => 1;
  @override
  int get oneLogLevelDebug => 1;
  @override
  int get oneLogLevelWarning => 2;
  @override
  int get oneLogLevelError => 3;
  @override
  int get oneLogLevelNone => 10;
}
