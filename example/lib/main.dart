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

class CounterIncrementor extends StatelessWidget {
  const CounterIncrementor({required this.onPressed, Key? key})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Provide consent'),
    );
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // ApsisOne.setMinimumLogLevel(ONELogLevel.info);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          // child: Text('ApsisOne App Tool Example App'),
          child: CounterIncrementor(onPressed: _increment),
        ),
      ),
    );
  }

  void _increment() {
    setState(() {
      ApsisOne.setMinimumLogLevel(ONELogLevel.warning);
      // ApsisOne.provideConsent(ONEConsentType.collectData);
    });
  }
}