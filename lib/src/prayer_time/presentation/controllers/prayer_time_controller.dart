
import 'package:adhan/adhan.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

var api = "https://waktusholat.org/api/docs/today";

class CurrentLocation {
  double? latitute;
  double? longitute;

  CurrentLocation({this.latitute, this.longitute});
}

class PrayerTimeController extends GetxController {
  var currentLocation = CurrentLocation().obs;
  var serviceEnabled = true.obs;

  // Future<bool> _handlePermission() async {
  // bool serviceEnabled;
  // LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     _updatePositionList(
  //       _PositionItemType.log,
  //       _kLocationServicesDisabledMessage,
  //     );

  //     return false;
  //   }

  //   permission = await _geolocatorPlatform.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await _geolocatorPlatform.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       _updatePositionList(
  //         _PositionItemType.log,
  //         _kPermissionDeniedMessage,
  //       );

  //       return false;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     _updatePositionList(
  //       _PositionItemType.log,
  //       _kPermissionDeniedForeverMessage,
  //     );

  //     return false;
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   _updatePositionList(
  //     _PositionItemType.log,
  //     _kPermissionGrantedMessage,
  //   );
  //   return true;
  // }

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // check if service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    return true;
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void getPrayerTimeToday() {
    final myCoordinates = Coordinates(23.9088, 89.1220);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);

    print(
        "---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");

    print(prayerTimes.fajr);
    print(prayerTimes.sunrise);
    print(prayerTimes.dhuhr);
    print(prayerTimes.asr);
    print(prayerTimes.maghrib);
    print(prayerTimes.isha);
  }

  void getPrayerTimeCustom() {
    // Custom Timezone Usage. (Most of you won't need this).
    // print('NewYork Prayer Times');
    // final newYork = Coordinates(35.7750, -78.6336);
    // final nyUtcOffset = Duration(hours: -4);
    // final nyDate = DateComponents(2015, 7, 12);
    // final nyParams = CalculationMethod.north_america.getParameters();
    // nyParams.madhab = Madhab.hanafi;
    // final nyPrayerTimes =
    //     PrayerTimes(newYork, nyDate, nyParams, utcOffset: nyUtcOffset);

    // print(nyPrayerTimes.fajr.timeZoneName);
    // print(nyPrayerTimes.fajr);
    // print(nyPrayerTimes.sunrise);
    // print(nyPrayerTimes.dhuhr);
    // print(nyPrayerTimes.asr);
    // print(nyPrayerTimes.maghrib);
    // print(nyPrayerTimes.isha);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
