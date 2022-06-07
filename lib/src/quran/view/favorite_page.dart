import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/src/profile/controllers/user_controller.dart';
import 'package:quran_app/src/profile/views/signin_page.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/view/surah_detail_page.dart';
import 'package:quran_app/src/quran/widget/confirm_delete_favorite.dart';
import 'package:quran_app/src/quran/widget/shimmer/surah_card_shimmer.dart';
import 'package:quran_app/src/quran/widget/surah_item.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:unicons/unicons.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final surahFavoriteC = Get.put(SurahFavoriteController());
    final surahC = Get.put(SurahController());
    final userC = Get.put(UserControllerImpl());

    if (userC.user.id != null) {
      if (surahC.surahFavorites.isEmpty) {
        surahC.fetchSurahFavorites(userC.user.id!);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite",
          style: AppTextStyle.bigTitle,
        ),
        actions: [
          Obx(
            () => userC.user.email == null
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      Get.dialog(ConfirmDeleteFavorite(
                        message:
                            "Are you sure you want \nto remove all from favorite?",
                        onCancel: () => Get.back(),
                        onDelete: () {
                          surahC.removeAllFromFavorite(userC.user.id!);
                        },
                      ));
                    },
                    icon: const Icon(
                      UniconsLine.trash,
                    ),
                  ),
          ),
          const SizedBox(width: 8),
        ],
        centerTitle: true,
        elevation: 1,
      ),
      body: Obx(
        () => userC.user.email == null
            ? FadeIn(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/illustration/cannot-access-state.svg",
                        width: 190,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "Opps ...",
                        style: AppTextStyle.bigTitle,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Let's login first, then you can enjoy \nand explore this feature.",
                        style: AppTextStyle.normal.copyWith(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      MyButton(
                        width: MediaQuery.of(context).size.width * 0.7,
                        text: "Sign In",
                        onPressed: () => Get.to(SignInPage()),
                      ),
                    ],
                  ),
                ),
              )
            : surahC.isFavoriteLoaded.value
                ? ListView(
                    children: const [
                      SurahCardShimmer(amount: 5),
                    ],
                  )
                : surahC.surahFavorites.isEmpty
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/illustration/empty-state-list-1.svg",
                              width: 200,
                            ),
                            const SizedBox(height: 40),
                            Text(
                              "No Favorite",
                              style: AppTextStyle.bigTitle,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "You don't have any favorite \nsurah yet.",
                              style: AppTextStyle.normal.copyWith(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 1500));
                          surahC.fetchSurahFavorites(userC.user.id!);
                        },
                        backgroundColor: Theme.of(context).cardColor,
                        color: Theme.of(context).primaryColor,
                        strokeWidth: 3,
                        triggerMode: RefreshIndicatorTriggerMode.onEdge,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            itemBuilder: (ctx, i) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FadeInDown(
                                    child: Slidable(
                                      closeOnScroll: true,
                                      startActionPane: ActionPane(
                                        extentRatio: 0.3,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              Get.dialog(ConfirmDeleteFavorite(
                                                message:
                                                    "Are you sure you want to \nremove Surah \"${surahC.surahFavorites.toList()[i].name?.id}\" \nfrom favorite?",
                                                onCancel: () => Get.back(),
                                                onDelete: () {
                                                  surahC
                                                      .removeFromFavorite(
                                                        userC.user.id!,
                                                        surahC.surahFavorites
                                                            .toList()[i],
                                                      )
                                                      .then((value) =>
                                                          Get.back());
                                                },
                                              ));
                                            },
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            icon: UniconsLine.trash,
                                            autoClose: true,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          const SizedBox(width: 16),
                                        ],
                                      ),
                                      endActionPane: ActionPane(
                                        extentRatio: 0.3,
                                        motion: const ScrollMotion(),
                                        children: [
                                          const SizedBox(width: 16),
                                          SlidableAction(
                                            onPressed: (context) {
                                              Get.dialog(ConfirmDeleteFavorite(
                                                message:
                                                    "Are you sure you want to \nremove Surah \"${surahC.surahFavorites.toList()[i].name?.id}\" \nfrom favorite?",
                                                onCancel: () => Get.back(),
                                                onDelete: () {
                                                  surahC
                                                      .removeFromFavorite(
                                                        userC.user.id!,
                                                        surahC.surahFavorites
                                                            .toList()[i],
                                                      )
                                                      .then((value) =>
                                                          Get.back());
                                                },
                                              ));
                                            },
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            icon: UniconsLine.trash,
                                            autoClose: true,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ],
                                      ),
                                      child: InkWell(
                                        highlightColor: Colors.white12,
                                        splashColor: Colors.white12,
                                        onTap: () {
                                          surahC.setRecenlySurah(surahC
                                              .surahFavorites
                                              .toList()[i]);
                                          Get.to(
                                            SurahDetailPage(
                                              surah: surahC.surahFavorites
                                                  .toList()[i],
                                            ),
                                            routeName: 'surah-detail',
                                          );
                                        },
                                        child: SurahItem(
                                          number: surahC.surahFavorites
                                              .toList()[i]
                                              .number,
                                          nameShort: surahC.surahFavorites
                                              .toList()[i]
                                              .name!
                                              .arab,
                                          revelation: surahC.surahFavorites
                                              .toList()[i]
                                              .revelation!
                                              .id,
                                          nameTransliteration: surahC
                                              .surahFavorites
                                              .toList()[i]
                                              .name!
                                              .id,
                                          numberOfVerses: surahC.surahFavorites
                                              .toList()[i]
                                              .numberOfVerses,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (ctx, i) {
                              return const SizedBox(height: 10);
                            },
                            itemCount: surahC.surahFavorites.length,
                          ),
                        ),
                      ),
      ),
    );
  }
}
