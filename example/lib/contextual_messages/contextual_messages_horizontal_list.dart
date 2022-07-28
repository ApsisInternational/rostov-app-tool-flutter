import 'package:apsis_one/apsis_one.dart';
import 'package:flutter/material.dart';

class ContextualMessageHorizontalListView extends StatelessWidget {
  const ContextualMessageHorizontalListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> bannerIds = [
      'com.apsis1.messages.some-message-discriminator-banner1',
      'com.apsis1.messages.some-message-discriminator-banner2',
      'com.apsis1.messages.some-message-discriminator-banner3',
      'com.apsis1.messages.some-message-discriminator-banner4',
      'com.apsis1.messages.some-message-discriminator-banner5',
    ];
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: bannerIds.length,
      itemBuilder: (context, index) {
        return Container(
          child: ApsisOne.contextualMessageView(bannerIds[index]),
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.56,
        );
      },
    );
  }
}
