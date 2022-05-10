import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/view/search_surah_page.dart';
import 'package:quran_app/src/quran/view/surah_detail_page.dart';
import 'package:quran_app/src/quran/widget/shimmer/surah_card_shimmer.dart';
import 'package:quran_app/src/quran/widget/surah_item.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_drawer.dart';
import 'package:unicons/unicons.dart';

class SurahPage extends StatelessWidget {
  SurahPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final controller = Get.put(SurahController());

  // final settingsController = Get.put(SettingsController());

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
          icon: const Icon(
            UniconsLine.icons,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(SearchQuranPage.routeName),
            icon: const Icon(
              UniconsLine.search,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: AppDrawer(),
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
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1500));
            controller.fetchListOfSurah();
          },
          backgroundColor: Theme.of(context).cardColor,
          color: Theme.of(context).primaryColor,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: Obx(() {
            return controller.isLoading.value
                ? ListView(
                    children: const [
                      SurahCardShimmer(),
                    ],
                  )
                : SizedBox(
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
                            // if (i == 0)
                            //   Padding(
                            //     padding: const EdgeInsets.only(
                            //       bottom: 16,
                            //     ),
                            // child: InputText(
                            //   textController: TextEditingController(),
                            //   hintText: "Search surah",
                            //   prefixIcon: Icon(
                            //     UniconsLine.search,
                            //     color: Theme.of(context).primaryColor,
                            //   ),
                            //   onChanged: (v) {},
                            // ),
                            //   ),
                            Obx(
                              () => (controller.recenlySurah.name != null &&
                                      i == 0)
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                number: controller
                                                    .recenlySurah.number,
                                                nameShort: controller
                                                    .recenlySurah.name!.arab,
                                                revelation: controller
                                                    .recenlySurah
                                                    .revelation!
                                                    .id,
                                                nameTransliteration: controller
                                                    .recenlySurah.name!.id,
                                                nameTranslation: controller
                                                    .recenlySurah
                                                    .name!
                                                    .translationId,
                                                numberOfVerses: controller
                                                    .recenlySurah
                                                    .numberOfVerses,
                                              ),
                                            );
                                          },
                                          child: SurahItem(
                                            number:
                                                controller.recenlySurah.number,
                                            nameShort: controller
                                                .recenlySurah.name!.arab,
                                            nameTransliteration: controller
                                                .recenlySurah.name!.id,
                                            numberOfVerses: controller
                                                .recenlySurah.numberOfVerses,
                                            revelation: controller
                                                .recenlySurah.revelation!.id,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Divider(),
                                        const SizedBox(height: 10),
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                            FadeInDown(
                              child: InkWell(
                                highlightColor: Colors.white12,
                                splashColor: Colors.white12,
                                onTap: () {
                                  controller.setRecenlySurah(
                                      controller.listOfSurah[i]);
                                  Get.to(
                                    SurahDetailPage(
                                      number: controller.listOfSurah[i].number,
                                      nameShort:
                                          controller.listOfSurah[i].name!.arab,
                                      revelation: controller
                                          .listOfSurah[i].revelation!.id,
                                      nameTransliteration:
                                          controller.listOfSurah[i].name!.id,
                                      nameTranslation: controller
                                          .listOfSurah[i].name!.translationId,
                                      numberOfVerses: controller
                                          .listOfSurah[i].numberOfVerses,
                                    ),
                                    routeName: 'surah-detail',
                                  );
                                },
                                child: SurahItem(
                                  number: controller.listOfSurah[i].number,
                                  nameShort:
                                      controller.listOfSurah[i].name!.arab,
                                  revelation:
                                      controller.listOfSurah[i].revelation!.id,
                                  nameTransliteration:
                                      controller.listOfSurah[i].name!.id,
                                  numberOfVerses:
                                      controller.listOfSurah[i].numberOfVerses,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (ctx, i) {
                        return const SizedBox(height: 10);
                      },
                      itemCount: controller.listOfSurah.length,
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
