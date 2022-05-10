import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unicons/unicons.dart';

import '../../../services/notification_service.dart';
import '../../widgets/app_permission_status.dart';

class PrayerTimeNotifController extends GetxController {
  var enableFajr = false.obs;
  var enableSunrise = false.obs;
  var enableDhuhr = false.obs;
  var enableAsr = false.obs;
  var enableMaghrib = false.obs;
  var enableIsha = false.obs;
  var enableQiyam = false.obs;

  var fajrId = 0.obs;
  var sunriseId = 0.obs;
  var dhuhrId = 0.obs;
  var asrId = 0.obs;
  var maghribId = 0.obs;
  var ishaId = 0.obs;
  var qiyamId = 0.obs;

  void setScheduleId(String prayerTime, int id) {
    log("Set ID : " + prayerTime + " $id");
    switch (prayerTime.toLowerCase()) {
      case "fajr":
        fajrId.value = id;
        break;
      case "sunrise":
        sunriseId.value = id;
        break;
      case "dhuhr":
        dhuhrId.value = id;
        break;
      case "asr":
        asrId.value = id;
        break;
      case "maghrib":
        maghribId.value = id;
        break;
      case "isha":
        ishaId.value = id;
        break;
      case "qiyam":
        qiyamId.value = id;
        break;
      default:
    }
  }

  void createPrayerTimeNotif(String prayerTime) {
    int uniqueId = AwesomeNotify.createUniqueId();

    log("ID : " + uniqueId.toString());

    AwesomeNotify.createBasicNotif(
      id: uniqueId,
      title: "Prayer Times",
      body: "${prayerTime.capitalize} prayer time has arrived 🤩",
    ).then((value) {
      if (!value) {
        Get.snackbar("Opps", "Notification unallowed");
      }
    });
  }

  void createPrayerTimeReminder({
    required String prayerTime,
    required DateTime dateTime,
    required int hour,
    required int minute,
  }) {
    int uniqueId = AwesomeNotify.createUniqueId();
    setScheduleId(prayerTime, uniqueId);

    log("ID : " + uniqueId.toString());
    log("DateTime : " + dateTime.toString());

    AwesomeNotify.createScheduleNotif(
      id: uniqueId,
      title: "Prayer Times Reminder",
      body: minute != 0
          ? "${prayerTime.capitalize} prayer time is coming soon in ${Duration(seconds: minute).inMinutes} minutes, let's get ready 🤩"
          : "${prayerTime.capitalize} prayer time has arrived, let's do the prayer 🚀",
      dateTime: dateTime,
      hour: hour,
      minute: minute,
    ).then((bool value) {
      if (!value) {
        Get.bottomSheet(
          AppPermissionStatus(
            icon: Icons.notifications_none,
            title: "Allow Notifications",
            message: "Our app would like to send you notifications.",
            onPressed: () {
              AwesomeNotifications()
                  .requestPermissionToSendNotifications()
                  .then(
                (isAllowed) {
                  if (isAllowed == true) {
                    Get.back();
                  } else {
                    Get.snackbar("Opps", "Notification unallowed");
                  }
                },
              );
            },
          ),
        );
      }
    });
  }

  void writeBox({required String key, required String value}) async {
    final box = Get.find<GetStorage>();
    await box.write(key, value);

    final a = box.read(key);
    log("VALUE " + a);
  }

  bool readBox({required String key}) {
    final box = Get.find<GetStorage>();
    final value = box.read(key);
    log("VALUE READ " + value.toString());

    if (value != null) {
      if (value == 'true') {
        return true;
      }

      return false;
    }
    return false;
  }

  @override
  void onInit() {
    super.onInit();

    enableFajr.value = readBox(key: 'fajr_notif');
    enableSunrise.value = readBox(key: 'sunrise_notif');
    enableDhuhr.value = readBox(key: 'dhuhr_notif');
    enableAsr.value = readBox(key: 'asr_notif');
    enableMaghrib.value = readBox(key: 'maghrib_notif');
    enableIsha.value = readBox(key: 'isha_notif');
    enableQiyam.value = readBox(key: 'qiyam_notif');

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        Get.bottomSheet(
          AppPermissionStatus(
            icon: UniconsLine.bell_slash,
            title: "Allow Notification",
            message: "Our app would like to send you notifications.",
            onPressed: () {
              AwesomeNotifications()
                  .requestPermissionToSendNotifications()
                  .then(
                    (value) => Get.back(),
                  );
            },
          ),
        );
      }
    });

    // AwesomeNotifications().createdStream.listen((notification) {
    //   Get.snackbar("Wooho", 'Notifications enabled.');
      // on ${notification.channelKey}');
      // AwesomeNotifications().s;
    // });

    AwesomeNotifications().actionStream.listen((notification) {
      if ((notification.channelKey == 'basic_channel' ||
              notification.channelKey == 'schedule_notif') &&
          GetPlatform.isIOS) {
        // AwesomeNotifications().getGlobalBadgeCounter().then(
        //       (value) => AwesomeNotifications()
        //           .setGlobalBadgeCounter(value - 1)
        //           .then((_) => Get.off(SurahPage())),
        //     );

        AwesomeNotifications().decrementGlobalBadgeCounter();
      }
    });
  }

  @override
  void onClose() {
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();

    super.onClose();
  }
}
