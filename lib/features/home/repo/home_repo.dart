import 'package:flutter/services.dart';

class HomeRepo {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  Future<String> getBatteryLevel() async {
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      return 'Battery level at $result % .';
    } on PlatformException catch (e) {
      return "Failed to get battery level: '${e.message}'.";
    }
  }
}
