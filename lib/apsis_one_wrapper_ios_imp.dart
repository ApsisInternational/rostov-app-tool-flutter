import 'apsis_one_wrapper.dart';
import 'package:flutter/services.dart';

class ApsisOneIOS_Imp implements ApsisOneFlutter {
  static const MethodChannel _channel = MethodChannel('apsis_one');

  @override
  Future<void> setMinimumLogLevel(int level) async {
    print('LogLevel set iOS implementation');
    await _channel.invokeMethod('setMinimumLogLevel', {'logLevel':level});
  }

  @override
  Future<void> provideConsent(int consentType) async {
    print('Provide consent iOS implementation');
    await _channel.invokeMethod('provideConsent', {'consentType':consentType});
  }
  
  @override
  Future<void> removeConsent(int consentType) async {
    print('Remove consent iOS implementation');
    await _channel.invokeMethod('removeConsent', {'consentType':consentType});
  }

  @override
  Future<void> trackScreenViewEvent(String event) async {
    print('Track manually screenView iOS implementation');
    await _channel.invokeMethod('trackScreenViewEvent', {'event':event});
  }

  @override
  Future<void> trackCustomEvent(String eventId, Map data) async {
    print('Track customEvent iOS implementation');
    await _channel.invokeMethod('trackCustomEvent', {'eventId':eventId, 'data':data});
  }

  @override
  Future<void> trackLocation(double latitude, double longitude, String placemarkName, String placemarAddress, int accuracy) async {
    print('Track location iOS implementation');
    await _channel.invokeMethod('trackLocation', {'latitude':latitude, 'longitude':longitude, 'placemarkName':placemarkName, 'placemarAddress':placemarAddress, 'accuracy':accuracy});
  }

  @override
  Future<void> startCollectingLocation(int frequency) async {
    print('Start collecting location iOS implementation');
    await _channel.invokeMethod('startCollectingLocation', {'frequency':frequency});
  }
  
  @override
  Future<void> stopCollectingLocation() async {
    print('Stop collecting location iOS implementation');
    await _channel.invokeMethod('stopCollectingLocation'); 
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