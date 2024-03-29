import 'package:flutter/material.dart';
import 'dart:async';

import 'package:apsis_one/apsis_one.dart';
import 'first.dart';
import 'extras.dart';
import 'details.dart';
import 'contextual_messages/contextual1.dart';
import 'contextual_messages/contextual2.dart';
import 'contextual_messages/contextual_message_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _showDialog(BuildContext context) {
    BlurryDialog alert =
        const BlurryDialog('Consents', 'Collection Data Consent was lost');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
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
        '/': (context) => const MyHomePage(),
        '/SecondFlutterView': (context) => const DetailView(),
        '/ContextualView1': (context) => const ContextualView1(),
        '/ContextualView2': (context) => const ContextualView2(),
        '/ContextualView3': (context) => const ContextualMessageView(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AppsisOne App Tool example'),
        ),
        body: const FirstPage());
  }
}
