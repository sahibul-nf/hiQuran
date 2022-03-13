import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_app/shared_value.dart';
import 'package:quran_app/src/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // supabase initialize
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  Get.put<GetStorage>(GetStorage());

  runApp(const MyApp());
}
