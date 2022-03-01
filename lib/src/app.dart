import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/quran/view/surah_page.dart';
import 'package:quran_app/src/settings/settings_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hiQuran',
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      home: const SurahPage(),
      // home: MainPage(),
      // initialRoute: "/",
      // routes: {
      //   "/a" => SurahPage(),
      // },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = [
    SurahPage(),
    const SettingsPage(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
        child: BottomNavigationBar(
          backgroundColor: context.theme.cardColor,
          currentIndex: _index,
          selectedFontSize: 12,
          iconSize: 30,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            setState(() {
              _index = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.document),
              label: "Quran",
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.heart),
              label: "Favorite",
            ),
          ],
        ),
      ),
    );
  }
}
