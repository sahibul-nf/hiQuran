import 'package:get/route_manager.dart';
import 'package:quran_app/src/settings/settings_page.dart';

import 'home/view/home_page.dart';
import 'prayer_time/views/prayer_time_page.dart';
import 'prayer_time/views/qiblat_page.dart';
import 'quran/view/search_surah_page.dart';
import 'quran/view/surah_page.dart';
import 'wrapper.dart';

abstract class Routes {
  static List<GetPage<dynamic>>? pages = [
    GetPage(name: "/", page: () => Wrapper()),
    GetPage(name: "/home", page: () => HomePage()),
    GetPage(name: "/surah", page: () => SurahPage()),
    GetPage(name: "/prayer-times", page: () => PrayerTimePage()),
    GetPage(name: "/qiblat", page: () => QiblatPage()),
    GetPage(name: "/setting", page: () => const SettingsPage()),
    GetPage(
      name: SearchQuranPage.routeName,
      page: () => SearchQuranPage(),
    )
  ];
}
