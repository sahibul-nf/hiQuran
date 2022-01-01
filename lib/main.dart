import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/quran/view/surah_detail_page.dart';
import 'package:quran_app/quran/view/surah_page.dart';
import 'package:quran_app/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: ColorPalletes.sapphire,
        backgroundColor: ColorPalletes.bgColor,
      ),
      home: SurahPage(),
    );
  }
}
