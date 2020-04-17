import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dropdown_menu/flutter_dropdown_menu.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_dropdown_menu');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterDropdownMenu.platformVersion, '42');
  });
}
