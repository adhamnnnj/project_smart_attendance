import 'package:flutter/services.dart';

class BeaconHelper {
  static const MethodChannel _channel = MethodChannel('com.example/smartattendance1');

  static Future<void> startBeacon() async {
    try {
      final result = await _channel.invokeMethod('startBeacon');
      print(result); // Logs "Beacon started"
    } catch (e) {
      print("Beacon start failed: $e");
    }
  }
}
