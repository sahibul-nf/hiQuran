import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/search_bar.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/view/surah_detail_page.dart';
import 'package:quran_app/src/quran/widget/shimmer/surah_card_shimmer.dart';
import 'package:quran_app/src/quran/widget/surah_item.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/settings_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_drawer.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({Key? key}) : super(key: key);

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final controller = Get.put(SurahController());
  // final settingsController = Get.put(SettingsController());

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(
          "Quran",
          style: AppTextStyle.bigTitle,
        ),
        leading: IconButton(
          onPressed: () => _key.currentState!.openDrawer(),
          icon: Unicon(
            Unicons.uniBars,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      drawer: AppDrawer(),
      body: Obx(() {
        return controller.isLoading.value
            ? const SurahCardShimmer()
            : ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  Obx(() {
                    return controller.recenlySurah.name != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recenly",
                                style: AppTextStyle.title,
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    SurahDetailPage(
                                      number: controller.recenlySurah.number,
                                      nameShort:
                                          controller.recenlySurah.name!.arab,
                                      revelation: controller
                                          .recenlySurah.revelation!.id,
                                      nameTransliteration:
                                          controller.recenlySurah.name!.id,
                                      nameTranslation: controller
                                          .recenlySurah.name!.translationId,
                                      numberOfVerses: controller
                                          .recenlySurah.numberOfVerses,
                                    ),
                                  );
                                },
                                child: SurahItem(
                                  number: controller.recenlySurah.number,
                                  nameShort: controller.recenlySurah.name!.arab,
                                  nameTransliteration:
                                      controller.recenlySurah.name!.id,
                                  numberOfVerses:
                                      controller.recenlySurah.numberOfVerses,
                                  revelation:
                                      controller.recenlySurah.revelation!.id,
                                ),
                              ),
                              const Divider(),
                              const SizedBox(height: 20),
                            ],
                          )
                        : const SizedBox();
                  }),
                  for (var item in controller.listOfSurah)
                    FadeInDown(
                      child: InkWell(
                        highlightColor: Colors.white12,
                        splashColor: Colors.white12,
                        onTap: () {
                          Get.to(
                            SurahDetailPage(
                              number: item.number,
                              nameShort: item.name!.arab,
                              revelation: item.revelation!.id,
                              nameTransliteration: item.name!.id,
                              nameTranslation: item.name!.translationId,
                              numberOfVerses: item.numberOfVerses,
                            ),
                          );
                          controller.setRecenlySurah(item);
                        },
                        child: SurahItem(
                          number: item.number,
                          nameShort: item.name!.arab,
                          revelation: item.revelation!.id,
                          nameTransliteration: item.name!.id,
                          numberOfVerses: item.numberOfVerses,
                        ),
                      ),
                    ),
                ],
              );
      }),
    );
  }
}
