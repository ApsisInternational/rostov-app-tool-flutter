import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AndroidHybridView extends StatelessWidget {

  const AndroidHybridView({required this.discriminator, Key? key}) : super(key: key);
  final String discriminator;

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'ApsisContextualView';
    // Pass parameters to the platform side.
    Map<String, dynamic> creationParams = <String, dynamic>{
      'discriminator': this.discriminator
    };
    //print('Build ApsisHybridView');

    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory:
      (context, controller) {
        //print('PlatformViewLink surfaceFactory');
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        //print('PlatformViewLink onCreatePlatformView');
        return PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
        ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
        ..create();
      },
    );
  }
}
