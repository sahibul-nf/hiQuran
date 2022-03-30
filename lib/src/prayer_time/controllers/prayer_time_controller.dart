import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/prayer_time/formatters/result_formatter.dart';
import 'package:quran_app/src/prayer_time/models/prayer_time.dart';
import 'package:quran_app/src/widgets/app_permission_status.dart';

var api = "https://waktusholat.org/api/docs/today";

class _CurrentLocation {
  double latitude;
  double longitude;

  _CurrentLocation({this.latitude = 0, this.longitude = 0});
}

const String _kLocationServicesDisabledMessage =
    'Location services are disabled.';
const String _kPermissionDeniedMessage = 'Permission denied.';
const String _kPermissionDeniedForeverMessage =
    "Please, enable this app's location permission in settings to use this feature.";
const String _kPermissionGrantedMessage = 'Permission granted.';

abstract class PrayerTimeController extends GetxController {
  Future<LocationResultFormatter> handleLocationPermission();
  Future<bool> openAppSetting();
  Future<void> getLocation();
  void getPrayerTimesToday(double latitude, double longitude);
  void getAddressLocationDetail(double latitude, double longitude);
}

class PrayerTimeControllerImpl extends PrayerTimeController {
  var currentLocation = _CurrentLocation().obs;
  var prayerTimesToday = PrayerTime().obs;
  var nextPrayer = Prayer.none.obs;
  var currentPrayer = Prayer.none.obs;
  var currentAddress = Placemark().obs;
  var leftOver = 0.obs;
  var sensorIsSupported = false.obs;
  var qiblahDirection = 0.0.obs;

  @override
  Future<LocationResultFormatter> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // check if service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return LocationResultFormatter(false, _kLocationServicesDisabledMessage);
    }

    // check permission location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationResultFormatter(false, _kPermissionDeniedMessage);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationResultFormatter(false, _kPermissionDeniedForeverMessage);
    }

    return LocationResultFormatter(true, _kPermissionGrantedMessage);
  }

  @override
  Future<bool> openAppSetting() async {
    final opened = await Geolocator.openAppSettings();
    if (opened) {
      log("Opened location setting");
    } else {
      log("Error opening location setting");
    }

    return opened;
  }

  @override
  Future<void> getLocation() async {
    final handlePermission = await handleLocationPermission();

    if (!handlePermission.result) {
      Get.bottomSheet(AppPermissionStatus(
        message: handlePermission.error.toString(),
      ));
    } else {
      final location = await Geolocator.getCurrentPosition();
      var loc = _CurrentLocation(
        latitude: location.latitude,
        longitude: location.longitude,
      );

      currentLocation(loc);
      getPrayerTimesToday(location.latitude, location.longitude);
      getAddressLocationDetail(location.latitude, location.longitude);
      getQiblah(location.latitude, location.longitude);
    }
  }

  @override
  void getPrayerTimesToday(double latitude, double longitude) {
    log(latitude.toString());
    log(longitude.toString());

    final myCoordinates = Coordinates(latitude, longitude);

    final params = CalculationMethod.singapore.getParameters();
    params.madhab = Madhab.shafi;
    final prayerTimes = PrayerTimes.today(myCoordinates, params);
    final sunnahTimes = SunnahTimes(prayerTimes);

    log("---Today's Prayer Times in Your Local Timezone(${prayerTimes.fajr.timeZoneName})---");

    log(prayerTimes.fajr.toString());
    log(prayerTimes.sunrise.toString());
    log(prayerTimes.dhuhr.toString());
    log(prayerTimes.asr.toString());
    log(prayerTimes.maghrib.toString());
    log(prayerTimes.isha.toString());
    log(sunnahTimes.middleOfTheNight.toString());
    log(sunnahTimes.lastThirdOfTheNight.toString());

    var result = PrayerTime(
      shubuh: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhur: prayerTimes.dhuhr,
      ashar: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isya: prayerTimes.isha,
      middleOfTheNight: sunnahTimes.middleOfTheNight,
      lastThirdOfTheNight: sunnahTimes.lastThirdOfTheNight,
    );

    currentPrayer(nextPrayer.value);
    nextPrayer(prayerTimes.nextPrayer());
    log("Next prayer: ${prayerTimes.nextPrayer()}");

    prayerTimesToday(result);
    prayerTimesToday.value = result;
  }

  @override
  void getAddressLocationDetail(double latitude, double longitude) async {
    List<Placemark> placeMarks;
    try {
      log("$latitude");
      log("$longitude");
      placeMarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      var address = placeMarks[0];

      log("$address");
      currentAddress(address);
    } on PlatformException catch (e) {
      log(e.toString());
      await Future.delayed(const Duration(milliseconds: 300));
      try {
        placeMarks = await placemarkFromCoordinates(latitude, longitude);
        var address = placeMarks[0];

        log("$address");
        currentAddress(address);
      } catch (e) {
        Get.snackbar(
            "Opps", 'Address was not retrieved, please fill out manually');
      }
    }
  }

  void getQiblah(double latitude, double longitude) {
    final myCoordinates = Coordinates(latitude, longitude);

    final qiblah = Qibla(myCoordinates);
    log("Qiblah: ${qiblah.direction}");
    qiblahDirection.value = qiblah.direction;
  }

  Future<void> checkDeviceSensorSupport() async {
    FlutterQiblah.androidDeviceSensorSupport().then((value) {
      if (value != null) {
        sensorIsSupported.value = value;
        log("Check $value");
      }
      log("Check $value");
    });
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
    getLocation();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
