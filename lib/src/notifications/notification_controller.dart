import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:quran_app/src/notifications/notification_page.dart';
import 'package:quran_app/src/notifications/notification_service.dart';

class NotificationController extends GetxController {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  var totalNotifications = 0.obs;
  Rx<PushNotification?> notificationInfo = PushNotification().obs;

  void pushFCMToken() async {
    String? token = await _messaging.getToken();
    print(token);
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

  // void initMessaging() {

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       // fltNotification.show(notification.hashCode, notification.title,
  //       //     notification.body, generalNotificationDetails);
  //       AwesomeNotifications().createNotificationFromJsonData(message.data);
  //     }
  //   });

  // }

  void initMessaging() async {
    // await Firebase.initializeApp();

    // take user permission on iOS
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;

          log(message.notification!.title.toString());

          if (notification != null && android != null) {
            PushNotification pushNotification = PushNotification(
              title: notification.title,
              body: notification.body,
              dataTitle: message.data['title'],
              dataBody: message.data['body'],
            );

            notificationInfo.value = pushNotification;
            totalNotifications.value++;

            log(totalNotifications.toString());
          }

          if (notificationInfo.value != null) {
            showSimpleNotification(
              Text("${notificationInfo.value?.title}"),
              leading: NotificationBadge(
                  totalNotifications: totalNotifications.value),
              subtitle: Text("${notificationInfo.value?.title}"),
              background: Colors.cyan.shade700,
              duration: const Duration(seconds: 4),
            );
          }
        },
      );

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
        dataTitle: initialMessage.data['title'],
        dataBody: initialMessage.data['body'],
      );
      notificationInfo.value = notification;
      totalNotifications.value++;
    }
  }

  @override
  void onInit() {
    pushFCMToken();
    initMessaging();

    checkForInitialMessage();

    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );
      notificationInfo.value = notification;
      totalNotifications.value++;
    });
    super.onInit();
  }
}

class PushNotification {
  String? title;
  String? body;
  String? dataTitle;
  String? dataBody;

  PushNotification({this.title, this.body, this.dataTitle, this.dataBody});
}
