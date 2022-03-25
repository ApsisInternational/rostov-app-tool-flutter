import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:apsis_one/apsis_one.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class CustomButton extends StatelessWidget {
  const CustomButton({required this.onPressed, required this.title, Key? key})
      : super(key: key);

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    ApsisOne.setMinimumLogLevel(ONELogLevel.info);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton (onPressed: _provideCollectDataConsent,  title: 'Provide data consent'),
              CustomButton (onPressed: _removeCollectDataConsent,  title: 'Remove data consent'),
              CustomButton (onPressed: _provideCollectLocationConsent,  title: 'Provide location consent'),
              CustomButton (onPressed: _removeCollectLocationConsent,  title: 'Remove location consent'),
              CustomButton (onPressed: _trackScreenViewEvent,  title: 'Track screenView event'),
              CustomButton (onPressed: _trackCustomEvent,  title: 'Track custom event'),
              CustomButton (onPressed: _trackCustomLocation,  title: 'Track custom location'),
              CustomButton (onPressed: _startCollectLocationLow,  title: 'Start collecting location low'),
              CustomButton (onPressed: _startCollectLocationMedium,  title: 'Start collecting location medium'),
              CustomButton (onPressed: _startCollectLocationHigh,  title: 'Start collecting location high'),
              CustomButton (onPressed: _stopCollectLocation,  title: 'Stop collecting location'),
            ],
          ),
        ),
      ),
    );
  }

  void _provideCollectDataConsent() {
    setState(() {
      ApsisOne.provideConsent(ONEConsentType.collectData);
    });
  }

  void _removeCollectDataConsent() {
    setState(() {
      ApsisOne.removeConsent(ONEConsentType.collectData);
    });
  }

  void _provideCollectLocationConsent() {
    setState(() {
      ApsisOne.provideConsent(ONEConsentType.collectLocation);
    });
  }

  void _removeCollectLocationConsent() {
    setState(() {
      ApsisOne.removeConsent(ONEConsentType.collectLocation);
    });
  }

  void _trackScreenViewEvent() {
    setState(() {
      ApsisOne.trackScreenViewEvent('Custom view title');
    });
  }

  void _trackCustomEvent() {
    setState(() {
      var testCustomEventData = {
        'source' : 'testSource',
        'number' : 321,
        'numberWithDecimal' : 3.14159,
        'text' : 'testText',
        'trueFalse' : true
      };
      ApsisOne.trackCustomEvent('com.apsis1.events.transaction.custom-testcustomevent-3c3yitjo4j', testCustomEventData);
    });
  }

  void _trackCustomLocation() {
    setState(() {
      ApsisOne.trackLocation(53.425, 38.543, 'Test placemark name', 'Test placemark address', 3);
    });
  }

  void _startCollectLocationLow() {
    setState(() {
      ApsisOne.startCollectingLocation(ONELocationFrequency.low);
    });
  }

  void _startCollectLocationMedium() {
    setState(() {
      ApsisOne.startCollectingLocation(ONELocationFrequency.medium);
    });
  }

  void _startCollectLocationHigh() {
    setState(() {
      ApsisOne.startCollectingLocation(ONELocationFrequency.high);
    });
  }

  void _stopCollectLocation() {
    setState(() {
      ApsisOne.stopCollectingLocation();
    });
  }
}