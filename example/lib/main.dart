import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:apsis_one/apsis_one.dart';
import 'second.dart';

void main() {
  runApp(MaterialApp(home:MyApp()));
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

class BlurryDialog extends StatelessWidget {
  String title;
  String content;

  BlurryDialog(this.title, this.content);
  TextStyle textStyle = TextStyle (color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child:  AlertDialog(
      title: new Text(title,style: textStyle,),
      content: new Text(content, style: textStyle,),
      actions: <Widget>[
        new FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      ));
  }
}

class _MyAppState extends State<MyApp> {
  static const MethodChannel _methodChannel = MethodChannel('com.apsis.one/sampleapp');

  _showDialog(BuildContext context) {
    BlurryDialog alert = BlurryDialog("Consents","Collection Data Consent was lost");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      }
    );
  }

  Future<dynamic> handler(ONEConsentType consentType) async {
    if (consentType == ONEConsentType.collectData) {
      _showDialog(context);  
    }
  }

  @override
  void initState() {
    super.initState();
    ApsisOne.setMinimumLogLevel(ONELogLevel.info);
    ApsisOne.subscribeOnConsentLost(handler);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ApsisOne Flutter Example App'),
        ),
        body: Center(
          child: Center(child: mainMenu()),
        ),
      ),
    );
  }

  Widget mainMenu() {
    return Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomButton (onPressed: _provideCollectDataConsent, title: 'Provide data consent'),
              CustomButton (onPressed: _removeCollectDataConsent, title: 'Remove data consent'),
              CustomButton (onPressed: _provideCollectLocationConsent, title: 'Provide location consent'),
              CustomButton (onPressed: _removeCollectLocationConsent, title: 'Remove location consent'),
              CustomButton (onPressed: _trackScreenViewEvent, title: 'Track screenView event'),
              CustomButton (onPressed: _trackCustomEvent, title: 'Track custom event'),
              CustomButton (onPressed: _trackCustomLocation, title: 'Track custom location'),
              CustomButton (onPressed: _startCollectLocationLow, title: 'Start collecting location low'),
              CustomButton (onPressed: _startCollectLocationMedium, title: 'Start collecting location medium'),
              CustomButton (onPressed: _startCollectLocationHigh, title: 'Start collecting location high'),
              CustomButton (onPressed: _stopCollectLocation, title: 'Stop collecting location'),
              CustomButton (onPressed: _presentCustomView, title: 'Present Custom view'),
              CustomButton (onPressed: _presentView, title: 'iOS Present Modally native view'),
            ],
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
      ApsisOne.trackCustomEvent('com.apsis1.events.transaction.custom-testcustomevent-651e5udu28', testCustomEventData);
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

  void _presentCustomView() {
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new DetailView()));
  }

  Future<void> _presentView() async {
    await _methodChannel.invokeMethod('switchView');
  }
}
