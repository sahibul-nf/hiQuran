import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/quran/view/surah_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorPalletes.sapphire,
        backgroundColor: ColorPalletes.bgColor,
      ),
      home: SurahPage(),
    );
  }
}