import 'package:apsis_one/apsis_one.dart';
import 'package:flutter/material.dart';

class ContextualMessageView extends StatelessWidget {
  const ContextualMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contextual Message view'),
        ),
        body: Column(children: [
          // flex: 25,
          Container(
            child: ApsisOne.contextualMessageView(
                "com.apsis1.messages.some-message-discriminator-banner1"),
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 0.56,
          ),
          Expanded(
            child: Container(
              child: ApsisOne.contextualMessageView(
                  "com.apsis1.messages.some-message-discriminator-9dh38wrqcd"),
              color: Colors.white,
            ),
          ),
        ]));
  }
}
