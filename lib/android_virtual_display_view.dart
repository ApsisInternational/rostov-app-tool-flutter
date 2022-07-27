import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidVirtualDisplayView extends StatelessWidget {

  const AndroidVirtualDisplayView({required this.discriminator, Key? key}) : super(key: key);

  final String discriminator;

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'ApsisContextualView';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'discriminator': this.discriminator
    };
    //print('Build ApsisVirtualDisplayView');

    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
