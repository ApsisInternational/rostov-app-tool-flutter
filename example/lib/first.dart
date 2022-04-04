import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:apsis_one/apsis_one.dart';
import 'extras.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  @override
  State<FirstPage> createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  static const MethodChannel _methodChannel =
      MethodChannel('com.apsis.one/sampleapp');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(child: mainMenu()),
    );
  }

  Widget mainMenu() {
    return SingleChildScrollView(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomButton(
            onPressed: _provideCollectDataConsent,
            title: 'Provide data consent'),
          CustomButton(
            onPressed: _removeCollectDataConsent, title: 'Remove data consent'),
          CustomButton(
            onPressed: _provideCollectLocationConsent,
            title: 'Provide location consent'),
          CustomButton(
            onPressed: _removeCollectLocationConsent,
            title: 'Remove location consent'),
          CustomButton(
            onPressed: _trackScreenViewEvent, title: 'Track screenView event'),
          CustomButton(onPressed: _trackCustomEvent, title: 'Track custom event'),
          CustomButton(
            onPressed: _trackCustomLocation, title: 'Track custom location'),
          CustomButton(
            onPressed: _startCollectLocationLow,
            title: 'Start collecting location low'),
          CustomButton(
            onPressed: _startCollectLocationMedium,
            title: 'Start collecting location medium'),
          CustomButton(
            onPressed: _startCollectLocationHigh,
            title: 'Start collecting location high'),
          CustomButton(
            onPressed: _stopCollectLocation, title: 'Stop collecting location'),
          CustomButton(
            onPressed: _presentCustomView, title: 'Present Custom view'),
          CustomButton(
            onPressed: _presentView, title: 'iOS Present Modally native view'),
        ],
      )
    );
  }

  void _provideCollectDataConsent() {
    ApsisOne.provideConsent(ONEConsentType.collectData);
  }

  void _removeCollectDataConsent() {
    ApsisOne.removeConsent(ONEConsentType.collectData);
  }

  void _provideCollectLocationConsent() {
    ApsisOne.provideConsent(ONEConsentType.collectLocation);
  }

  void _removeCollectLocationConsent() {
    ApsisOne.removeConsent(ONEConsentType.collectLocation);
  }

  void _trackScreenViewEvent() {
    ApsisOne.trackScreenViewEvent('Custom view title');
  }

  void _trackCustomEvent() {
    var testCustomEventData = {
      'source': 'testSource',
      'number': 321,
      'numberWithDecimal': 3.14159,
      'text': 'testText',
      'trueFalse': true
    };
    ApsisOne.trackCustomEvent(
        'com.apsis1.events.transaction.custom-testcustomevent-651e5udu28',
        testCustomEventData);
  }

  void _trackCustomLocation() {
    ApsisOne.trackLocation(59.325005, 18.070897, 'Test placemark name',
        'Test placemark address', 3);
  }

  void _startCollectLocationLow() {
    ApsisOne.startCollectingLocation(ONELocationFrequency.low);
  }

  void _startCollectLocationMedium() {
    ApsisOne.startCollectingLocation(ONELocationFrequency.medium);
  }

  void _startCollectLocationHigh() {
    ApsisOne.startCollectingLocation(ONELocationFrequency.high);
  }

  void _stopCollectLocation() {
    ApsisOne.stopCollectingLocation();
  }

  void _presentCustomView() {
    Navigator.pushNamed(context, '/SecondFlutterView');
  }

  Future<void> _presentView() async {
    await _methodChannel.invokeMethod('switchView');
  }
}
