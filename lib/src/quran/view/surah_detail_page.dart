import 'package:animate_do/animate_do.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
// import 'package:quran_app/src/quran/controller/audio_player_controller.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/model/verse.dart';
import 'package:quran_app/src/quran/widget/shimmer/surah_detail_page_shimmer.dart';
import 'package:quran_app/src/quran/widget/surah_card.dart';
import 'package:quran_app/src/quran/widget/tafsir_view.dart';
import 'package:quran_app/src/quran/widget/verse_item.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_loading.dart';

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
  // final audioPlayerController = Get.put(AudioPlayerController());

  Widget tafsirView = const SizedBox();

  @override
  Widget build(BuildContext context) {
    controller.resetVerses();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quran",
          style: AppTextStyle.bigTitle,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: ConnectivityWidgetWrapper(
        decoration: BoxDecoration(
          boxShadow: [AppShadow.card],
          color: ColorPalletes.frenchPink.withOpacity(0.2),
        ),
        messageStyle: AppTextStyle.small.copyWith(
          color: ColorPalletes.frenchPink,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        alignment: Alignment.topCenter,
        child: FutureBuilder(
          future: controller.fetchSurahByID(number),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoading();
              // return const SurahDetailPageShimmer();
            } else if (!snapshot.hasData) {
              return const SurahDetailPageShimmer();
            } else {
              return Obx(() {
                return Stack(
                  children: [
                    SingleChildScrollView(
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
                          // const SizedBox(height: 10),
                          if (!snapshot.hasData) const SurahDetailPageShimmer(),
                          for (var verse in controller.verses)
                            FadeInDown(
                              from: 50,
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
              });
            }
          },
        ),
      ),
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
