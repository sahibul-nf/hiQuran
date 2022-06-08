import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:unicons/unicons.dart';

import '../../../bricks/my_widgets/input_text.dart';
import '../../settings/theme/app_theme.dart';
import '../widget/surah_item.dart';
import 'surah_detail_page.dart';

class SearchQuranPage extends StatelessWidget {
  SearchQuranPage({Key? key}) : super(key: key);

  static const routeName = '/search-quran';

  final _search = TextEditingController();
  final controller = Get.find<SurahController>();

  final List<String> popularSearch = [
    "al-kahf",
    "al-waqi'ah",
    "yasin",
    "yusuf",
    "ar-rahman",
    "al-mulk"
  ];

  @override
  Widget build(BuildContext context) {
    controller.resetListOfSearchedSurah();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: AppTextStyle.bigTitle,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          children: [
            InputText(
              textController: _search,
              hintText: "Search here",
              prefixIcon: Icon(
                UniconsLine.search,
                color: Theme.of(context).primaryColor,
              ),
              onChanged: (v) {
                controller.searchSurah(_search.text.trim().toLowerCase());
              },
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    "Popular search :",
                    style: AppTextStyle.small,
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 8,
                    children: [
                      for (var item in popularSearch)
                        InkWell(
                          onTap: () {
                            controller.resetListOfSearchedSurah();
                            _search.text = item;
                            controller
                                .searchSurah(_search.text.trim().toLowerCase());
                          },
                          child: Chip(
                            backgroundColor: Get.isDarkMode
                                ? Theme.of(context).cardColor
                                : null,
                            label: Text(
                              item,
                              style: AppTextStyle.small,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () => (controller.listOfSerchedSurah.isNotEmpty)
                  ? const SizedBox(height: 20)
                  : const SizedBox(height: 40),
            ),
            Obx(
              () => controller.listOfSerchedSurah.isNotEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return FadeInDown(
                            child: InkWell(
                              highlightColor: Colors.white12,
                              splashColor: Colors.white12,
                              onTap: () {
                                controller.setRecenlySurah(
                                    controller.listOfSerchedSurah.toList()[i]);
                                Get.to(
                                  SurahDetailPage(
                                    surah: controller.listOfSerchedSurah
                                        .toList()[i],
                                  ),
                                  routeName:
                                      '/surah/${controller.listOfSerchedSurah.toList()[i].name!.id?.toLowerCase()}',
                                );
                              },
                              child: SurahItem(
                                isSearch: true,
                                term: _search.text.trim(),
                                number: controller.listOfSerchedSurah
                                    .toList()[i]
                                    .number,
                                nameShort: controller.listOfSerchedSurah
                                    .toList()[i]
                                    .name!
                                    .arab,
                                revelation: controller.listOfSerchedSurah
                                    .toList()[i]
                                    .revelation!
                                    .id,
                                nameTransliteration: controller
                                    .listOfSerchedSurah
                                    .toList()[i]
                                    .name!
                                    .id,
                                numberOfVerses: controller.listOfSerchedSurah
                                    .toList()[i]
                                    .numberOfVerses,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, i) =>
                            const SizedBox(height: 10),
                        itemCount: controller.listOfSerchedSurah.length,
                      ),
                    )
                  : Column(
                      children: [
                        Image.asset(
                          'assets/illustration/01-readTheQuran.png',
                          width: 250,
                        ),
                        Text(
                          // "What are you looking for?",
                          "What surah are you going \nto read today?",
                          style: AppTextStyle.title,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        DefaultTextStyle(
                          style: AppTextStyle.normal.copyWith(
                            // color: ColorPalletes.bgDarkColor,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              TyperAnimatedText(
                                // 'Text Quran',
                                "Ar-Rahman",
                                speed: const Duration(milliseconds: 100),
                              ),
                              TyperAnimatedText(
                                // 'Name of Surah',
                                "Al-Kahf",
                                speed: const Duration(milliseconds: 100),
                              ),
                              TyperAnimatedText(
                                "Yasin",
                                speed: const Duration(milliseconds: 100),
                              ),
                              TyperAnimatedText(
                                'or any else',
                                speed: const Duration(milliseconds: 100),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
