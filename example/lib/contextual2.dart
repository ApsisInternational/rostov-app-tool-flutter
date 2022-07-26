import 'package:flutter/material.dart';
import 'package:apsis_one/apsis_one.dart';

class ContextualView2 extends StatelessWidget {
  const ContextualView2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contextual view 2'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: ApsisOne.contextualMessageView("demo"),
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.56,
          ),
          Expanded(
            child: Container(
              child: ApsisOne.contextualMessageView("demo"),
              color: Colors.blue,
            ),
          ),
        ],
      )
    );
  }
}
