import 'package:flutter/material.dart';
import 'package:apsis_one/android_hybrid_view.dart';

class ContextualView1 extends StatelessWidget {

  const ContextualView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contextual view 1'),
      ),
      body: AndroidHybridView(
        discriminator: "demo"
      ),
    );
  }
}
