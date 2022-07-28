import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:apsis_one/apsis_one.dart';
import 'extras.dart';
import 'dart:io' show Platform;

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
    List<CustomButton> items = [];
    items.add(CustomButton(
        onPressed: _provideCollectDataConsent, title: 'Provide data consent'));
    items.add(CustomButton(
        onPressed: _removeCollectDataConsent, title: 'Remove data consent'));
    items.add(CustomButton(
        onPressed: _provideCollectLocationConsent,
        title: 'Provide location consent'));
    items.add(CustomButton(
        onPressed: _removeCollectLocationConsent,
        title: 'Remove location consent'));
    items.add(CustomButton(
        onPressed: _trackScreenViewEvent, title: 'Track screenView event'));
    items.add(CustomButton(
        onPressed: _trackCustomEvent, title: 'Track custom event'));
    items.add(CustomButton(
        onPressed: _trackCustomLocation, title: 'Track custom location'));
    items.add(CustomButton(
        onPressed: _startCollectLocationLow,
        title: 'Start collecting location low'));
    items.add(CustomButton(
        onPressed: _startCollectLocationMedium,
        title: 'Start collecting location medium'));
    items.add(CustomButton(
        onPressed: _startCollectLocationHigh,
        title: 'Start collecting location high'));
    items.add(CustomButton(
        onPressed: _stopCollectLocation, title: 'Stop collecting location'));
    items.add(CustomButton(
        onPressed: _presentCustomView, title: 'Present Custom view'));

    //Platform dependent examples
    if (Platform.isAndroid) {
      items.add(CustomButton(
          onPressed: _presentContextualView1,
          title: 'Present Contextual view 1'));
      items.add(CustomButton(
          onPressed: _presentContextualView2,
          title: 'Present Contextual view 2'));
    } else if (Platform.isIOS) {
      items.add(CustomButton(
          onPressed: _presentView, title: 'Present native view modally'));
      items.add(CustomButton(
          onPressed: _presentContextualView3,
          title: 'Present Contextual View'));
    }

    return SingleChildScrollView(
        child: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: mainMenu(items)),
    ));
  }

  List<Widget> mainMenu(List<CustomButton> buttons) {
    return buttons;
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

  void _presentContextualView1() {
    Navigator.pushNamed(context, '/ContextualView1');
  }

  void _presentContextualView2() {
    Navigator.pushNamed(context, '/ContextualView2');
  }

  void _presentContextualView3() {
    Navigator.pushNamed(context, '/ContextualView3');
  }
}
