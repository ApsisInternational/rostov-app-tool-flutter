import 'package:flutter/widgets.dart';
import 'apsis_one_wrapper.dart';
import 'android_virtual_display_view.dart';
import 'package:flutter/services.dart';

class ApsisOneAndroid_Imp implements ApsisOneFlutter {
  final MethodChannel _channel = MethodChannel('com.apsis.one/publicapi');
  final EventChannel _eventChannel = EventChannel('com.apsis.one/consents');

  @override
  Future<void> setMinimumLogLevel(int level) async {
    print('LogLevel set Android implementation');
    await _channel.invokeMethod('setMinimumLogLevel', {'logLevel': level});
  }

  @override
  Future<void> provideConsent(int consentType) async {
    print('Provide consent Android implementation');
    await _channel.invokeMethod('provideConsent', {'consentType': consentType});
  }

  @override
  Future<void> removeConsent(int consentType) async {
    print('Remove consent Android implementation');
    await _channel.invokeMethod('removeConsent', {'consentType': consentType});
  }

  @override
  Future<void> trackScreenViewEvent(String event) async {
    print('Track manually screenView Android implementation');
    await _channel.invokeMethod('trackScreenViewEvent', {'event': event});
  }

  @override
  Future<void> trackCustomEvent(String eventId, Map data) async {
    print('Track customEvent Android implementation');
    await _channel
        .invokeMethod('trackCustomEvent', {'eventId': eventId, 'data': data});
  }

  @override
  Future<void> trackLocation(double latitude, double longitude,
      String placemarkName, String placemarkAddress, int accuracy) async {
    print('Track location Android implementation');
    await _channel.invokeMethod('trackLocation', {
      'latitude': latitude,
      'longitude': longitude,
      'placemarkName': placemarkName,
      'placemarkAddress': placemarkAddress,
      'accuracy': accuracy
    });
  }

  @override
  Future<void> startCollectingLocation(int frequency) async {
    print('Start collecting location Android implementation');
    await _channel
        .invokeMethod('startCollectingLocation', {'frequency': frequency});
  }

  @override
  Future<void> stopCollectingLocation() async {
    print('Stop collecting location Android implementation');
    await _channel.invokeMethod('stopCollectingLocation');
  }

  @override
  Future<void> subscribeOnConsentLost(
      Future<dynamic> handler(int consentType)) async {
    print('Subscribe on consent lost Android implementation');
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
  Widget contextualMessageView(String discriminator) {
    return AndroidVirtualDisplayView(discriminator: discriminator);
  }

  @override
  int get oneLocationFrequencyLow => 0;
  @override
  int get oneLocationFrequencyMedium => 0;
  @override
  int get oneLocationFrequencyHigh => 1;
  @override
  int get oneConsentTypeCollectData => 0;
  @override
  int get oneConsentTypeCollectLocation => 1;
  @override
  int get oneLogLevelInfo => 4;
  @override
  int get oneLogLevelDebug => 3;
  @override
  int get oneLogLevelWarning => 2;
  @override
  int get oneLogLevelError => 1;
  @override
  int get oneLogLevelNone => 0;
}
