import 'dart:async';

import 'package:flutter/services.dart';

export 'package:flutter_dropdown_menu/w_dropdown_menu/w_dropdown_header.dart';
export 'package:flutter_dropdown_menu/w_dropdown_menu/w_dropdown_menu.dart';
export 'package:flutter_dropdown_menu/w_dropdown_menu/w_dropdown_menu_controller.dart';

class FlutterDropdownMenu {
  static const MethodChannel _channel =
      const MethodChannel('flutter_dropdown_menu');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
