import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/src/app.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  String? supabaseUrl = dotenv.get("SUPABASE_URL");
  String? supabaseAnonKey = dotenv.get("SUPABASE_ANON_KEY");

  // local notification initialize
  // Notify.initialize();
  AwesomeNotifications().initialize(
    // 'resource://drawable/res_icon_100',
    null,
    [
      NotificationChannel(
        // channelGroupKey: "reminders",
        channelKey: "basic_notif",
        channelName: "Basic Notifications",
        channelDescription: "Basic notifications of hiQuran",
        channelShowBadge: true,
        defaultColor: ColorPalletes.azure,
        importance: NotificationImportance.High,
      ),
      NotificationChannel(
        // channelGroupKey: "reminders",
        channelKey: "schedule_notif",
        channelName: "Schedule Notifications",
        channelDescription: "Schedule notifications of hiQuran",
        channelShowBadge: true,
        locked: true,
        defaultColor: ColorPalletes.azure,
        importance: NotificationImportance.High,
      )
    ],
  );

  // firebase initialize
  await Firebase.initializeApp(
    name: 'hi-quran',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // supabase initialize
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  // local storage initialize
  Get.put<GetStorage>(GetStorage());

  // Get.put<NotificationController>(NotificationController());

  runApp(MyApp());
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");

//   // Use this method to automatically convert the push data, in case you gonna use our data standard
//   AwesomeNotifications().createNotificationFromJsonData(message.data);
// }
