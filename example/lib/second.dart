import 'dart:ui';
import 'package:flutter/material.dart';
import 'extras.dart';

class DetailView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second view'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Second view',
            ),
          ],
        ),
      ),
    );
  }

}