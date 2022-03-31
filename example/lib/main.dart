import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:apsis_one/apsis_one.dart';
import 'second.dart';
import 'first.dart';
import 'extras.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
      navigatorObservers: [ApsisOne.oneRouteObserver],
      routes: {
        '/': (context) => FirstPage(),
        '/SecondFlutterView': (context) => DetailView(),
      },
    );
  }
}