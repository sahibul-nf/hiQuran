import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/home/view/home_page.dart';
import 'package:quran_app/src/prayer_time/models/prayer_time.dart';
import 'package:quran_app/src/prayer_time/views/prayer_time_page.dart';
import 'package:quran_app/src/prayer_time/views/qiblat_page.dart';
import 'package:quran_app/src/quran/view/surah_page.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/settings_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/wrapper.dart';
import 'package:wiredash/wiredash.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _navigatorKey = GlobalKey<NavigatorState>();

  final settingC = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wiredash(
          projectId: "hiquran-la8pogf",
          secret: "Sn698m834hExb9tINXq1pdXjSRGMMAFs",
          navigatorKey: _navigatorKey,
          theme: WiredashThemeData(
            brightness:
                settingC.isDarkMode.value ? Brightness.dark : Brightness.light,
          ),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: _navigatorKey,
            title: 'hiQuran',
            darkTheme: AppTheme.dark,
            theme: AppTheme.light,
            // home: SignInPage(),
            home: Wrapper(),
            // home: HomePage(),
            // home: UploadAvatarPage(),
            // home: MainPage(),
            // initialRoute: "/",
            getPages: [
              GetPage(name: "/", page: () => Wrapper()),
              GetPage(name: "/home", page: () => HomePage()),
              GetPage(name: "/surah", page: () => SurahPage()),
              GetPage(name: "/prayer-times", page: () => PrayerTimePage()),
              GetPage(name: "/qiblat", page: () => QiblatPage())
            ],
          )),
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
