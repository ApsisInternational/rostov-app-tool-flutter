
import 'dart:async';

import 'package:flutter/services.dart';

class ApsisOne {
  static const MethodChannel _channel = MethodChannel('apsis_one');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
