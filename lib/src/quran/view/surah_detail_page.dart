import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:quran_app/src/profile/controllers/user_controller.dart';
import 'package:quran_app/src/profile/views/signin_page.dart';
// import 'package:quran_app/src/quran/controller/audio_player_controller.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/model/surah.dart';
import 'package:quran_app/src/quran/model/verse.dart';
import 'package:quran_app/src/quran/view/favorite_page.dart';
import 'package:quran_app/src/quran/widget/shimmer/surah_detail_page_shimmer.dart';
import 'package:quran_app/src/quran/widget/surah_card.dart';
import 'package:quran_app/src/quran/widget/tafsir_view.dart';
import 'package:quran_app/src/quran/widget/verse_item.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_loading.dart';
import 'package:quran_app/src/widgets/forbidden_card.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class SurahDetailPage extends StatelessWidget {
  SurahDetailPage({Key? key, required this.surah}) : super(key: key);
  final Surah surah;

  final controller = Get.find<SurahController>();
  final userC = Get.put(UserControllerImpl());
  // final audioPlayerController = Get.put(AudioPlayerController());

  Widget tafsirView = const SizedBox();

  @override
  Widget build(BuildContext context) {
    // controller.resetVerses();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quran",
          style: AppTextStyle.bigTitle,
        ),
        actions: [
          LikeButton(
            likeBuilder: (bool isLiked) {
              return Icon(
                Get.isDarkMode && isLiked
                    ? Icons.favorite
                    : !Get.isDarkMode && isLiked
                        ? Icons.favorite
                        : Get.isDarkMode || !isLiked
                            ? UniconsLine.heart
                            : UniconsLine.heart,
                color:
                    isLiked && Get.isDarkMode ? Colors.redAccent : Colors.white,
              );
            },
            circleColor: CircleColor(
              start: Colors.white,
              end: !Get.isDarkMode
                  ? Theme.of(context).primaryColor
                  : Colors.redAccent,
            ),
            bubblesColor: BubblesColor(
              dotPrimaryColor:
                  !Get.isDarkMode ? Theme.of(context).primaryColor : Colors.red,
              dotSecondaryColor: Colors.white,
            ),
            isLiked: controller.isFavorite(surah),
            onTap: (isLiked) async {
              if (userC.user.id != null) {
                if (controller.isFavorite(surah)) {
                  final result =
                      await controller.removeFromFavorite(106, surah);
                  return !result;
                } else {
                  final result = await controller.addToFavorite(106, surah);
                  return result;
                }
              } else {
                // Get.to(const FavoritePage(), routeName: '/favorite');
                Get.dialog(ForbiddenCard(
                  onPressed: () {
                    Get.back();
                    Get.to(SignInPage(), routeName: '/login');
                  },
                ));
                return false;
              }
            },
          ),
          const SizedBox(width: 10),
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
                          revelation: "${surah.revelation?.id}",
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
