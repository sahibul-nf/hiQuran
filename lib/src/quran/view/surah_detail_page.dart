import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/model/verse.dart';
import 'package:quran_app/src/quran/widget/shimmer/surah_card_shimmer.dart';
import 'package:quran_app/src/quran/widget/surah_card.dart';
import 'package:quran_app/src/quran/widget/tafsir_view.dart';
import 'package:quran_app/src/quran/widget/verse_item.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

// ignore: must_be_immutable
class SurahDetailPage extends StatelessWidget {
  SurahDetailPage(
      {Key? key,
      this.number,
      this.nameTransliteration,
      this.nameTranslation,
      this.revelation,
      this.nameShort,
      this.numberOfVerses})
      : super(key: key);
  final int? number;
  final String? nameTransliteration;
  final String? nameTranslation;
  final String? revelation;
  final String? nameShort;
  final int? numberOfVerses;

  final controller = Get.find<SurahController>();

  Widget tafsirView = const SizedBox();

  @override
  Widget build(BuildContext context) {
    controller.verses.clear();
    controller.fetchSurahByID(number);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$nameTransliteration",
          style: AppTextStyle.bigTitle.copyWith(),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        return Stack(
          children: [
            controller.isLoading.value
                ? const Center(
                    child: SurahCardShimmer(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SurahCard(
                          number: number,
                          nameShort: "$nameShort",
                          nameTranslation: "$nameTranslation",
                          nameTransliteration: "$nameTransliteration",
                          numberOfVerses: numberOfVerses,
                          revelation: "$revelation",
                        ),
                        const SizedBox(height: 10),
                        for (var verse in controller.verses)
                          FadeInDown(
                            delay: const Duration(milliseconds: 500),
                            child: VerseItem(
                              numberInSurah: verse.number!.inSurah,
                              textArab: verse.text!.arab,
                              textTransliteration:
                                  verse.text!.transliteration!.en,
                              textTranslation: verse.translation!.id,
                              onTapSeeTafsir: () {
                                if (controller.showTafsir.value) {
                                  controller.showTafsir.value = false;
                                }

                                controller.showTafsir.value = true;
                                _buildTafsirView(verse);
                              },
                            ),
                          ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
            if (controller.showTafsir.value) tafsirView,
          ],
        );
      }),
    );
  }

  _buildTafsirView(Verse verse) {
    tafsirView = TafsirView(
      textTafsir: verse.tafsir!.id!.long,
      numberInSurah: verse.number!.inSurah,
      closeShow: () {
        controller.showTafsir.value = false;
      },
    );
  }
}
