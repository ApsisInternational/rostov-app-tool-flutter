import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class IOSVirtualDisplayView extends StatelessWidget {
  const IOSVirtualDisplayView({required this.messageId, Key? key})
      : super(key: key);
  final String messageId;

  @override
  Widget build(BuildContext context) {
    const String viewType = 'com.apsis.one.contextualmessage';
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    creationParams['messageId'] = messageId;

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
