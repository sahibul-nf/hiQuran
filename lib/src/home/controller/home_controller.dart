import 'dart:developer';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentLocation = "".obs;

  void getLocation() async {
    try {
      final localTimeZone = await FlutterNativeTimezone.getLocalTimezone();
      currentLocation(localTimeZone);
    } catch (e) {
      log("Could not get the local timezone");
      log(e.toString());
    }
  }
  

  void a() async {
    // FlutterNativeTimezone.
  }
}
