import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quran_app/src/quran/controller/audio_player_controller.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/model/surah.dart';
import 'package:quran_app/src/quran/model/verse.dart';
import 'package:quran_app/src/quran/widget/shimmer/surah_detail_page_shimmer.dart';
import 'package:quran_app/src/quran/widget/surah_card.dart';
import 'package:quran_app/src/quran/widget/tafsir_view.dart';
import 'package:quran_app/src/quran/widget/verse_item.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_loading.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class SurahDetailPage extends StatelessWidget {
  SurahDetailPage(
      {Key? key,
      required this.surah})
      : super(key: key);
  final Surah surah;

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
        actions: [
          IconButton(
            onPressed: () {
              if (controller.isFavorite(surah)) {
                controller.removeFromFavorite(106, surah);
              } else {
                controller.addToFavorite(106, surah);
              }
            },
            icon: Obx(
              () => FadeIn(
                child: Icon(
                  controller.isFavorite(surah)
                      ? Icons.favorite
                      : UniconsLine.heart,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        centerTitle: true,
        elevation: 1,
      ),
      body: FutureBuilder(
        future: controller.fetchSurahByID(surah.number),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const AppLoading();
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
                          number: surah.number,
                          nameShort: "${surah.name}",
                          nameTranslation: "${surah.name?.translationId}",
                          nameTransliteration: "${surah.name?.id}",
                          numberOfVerses: surah.numberOfVerses,
                          revelation: "${surah.revelation}",
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
