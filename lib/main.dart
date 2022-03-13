import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/src/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // TODO: replace this before push to github
  // supabase initialize
  await Supabase.initialize(
    url: "https://cltlttpwsuuvpwugdyhm.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsdGx0dHB3c3V1dnB3dWdkeWhtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDY1ODk0MjksImV4cCI6MTk2MjE2NTQyOX0.W3bVTDGN_BGvmdQR6bAsBJsCwGZlyDA1JV-eU6SaTVg",
  );


  Get.put<GetStorage>(GetStorage());

  runApp(const MyApp());
}
