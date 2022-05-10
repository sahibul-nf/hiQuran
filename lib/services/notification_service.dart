import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:quran_app/helper/constans.dart';

class AwesomeNotify {
  static int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  static Future<bool> createBasicNotif({
    String? title,
    String? body,
    required int id,
  }) async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (isAllowed) {
      var illPray = AssetsName.illMuslimPray;
      return await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: "basic_notif",
          title: title,
          body: body,
          wakeUpScreen: true,
          bigPicture: "asset://$illPray",
          notificationLayout: NotificationLayout.BigPicture,
          // fullScreenIntent: true,
          // displayOnBackground: true,
          // displayOnForeground: true,
        ),
      );
    }
    return isAllowed;
  }

  static Future<bool> createScheduleNotif(
      {required int id,
      String? title,
      String? body,
      required DateTime dateTime,
      int? hour,
      int? minute}) async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (isAllowed) {
      var illPray = AssetsName.illMuslimPray;

      dateTime =
          dateTime.subtract(Duration(hours: hour ?? 0, seconds: minute ?? 0));

      log("DateTime After : " + dateTime.toString());

      return await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: "schedule_notif",
          title: title,
          body: body,
          notificationLayout: NotificationLayout.BigPicture,
          bigPicture: "asset://$illPray",
          wakeUpScreen: true,
          category: NotificationCategory.Reminder,
          criticalAlert: true,
          fullScreenIntent: (minute == 0) ? true : false,
          // displayOnBackground: true,
          // displayOnForeground: true,
        ),
        actionButtons: (minute == 0)
            ? [
                NotificationActionButton(
                  key: "mark_done",
                  label: "Mark Done",
                )
              ]
            : null,
        schedule: NotificationCalendar(
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          hour: dateTime.hour,
          minute: dateTime.minute,
          second: 0,
          millisecond: 0,
          repeats: true,
          preciseAlarm: true,
        ),
      );
    }
    return isAllowed;
  }

  static Future<void> cancelScheduledNotificationById(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
