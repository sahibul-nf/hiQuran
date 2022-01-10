import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/view/surah_detail_page.dart';
import 'package:quran_app/src/quran/widget/shimmer/surah_card_shimmer.dart';
import 'package:quran_app/src/quran/widget/surah_item.dart';
import 'package:quran_app/src/settings/settings_page.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({Key? key}) : super(key: key);

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final controller = Get.put(SurahController());

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(
          "MyQuran",
          style: AppTextStyle.bigTitle.copyWith(),
        ),
        leading: IconButton(
          onPressed: () => _key.currentState!.openDrawer(),
          icon: const Icon(Icons.menu_rounded),
        ),
        centerTitle: true,
      ),
      drawer: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: double.infinity,
          width: isHover
              // ignore: dead_code
              ? GetPlatform.isWeb
                  ? MediaQuery.of(context).size.width * 0.4
                  : MediaQuery.of(context).size.width * 0.3
              : GetPlatform.isWeb
                  ? MediaQuery.of(context).size.width * 0.1
                  : MediaQuery.of(context).size.width * 0.15,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onHover: (value) {
                  setState(() {
                    isHover = value;
                  });
                },
                onTap: () {
                  if (isHover) {
                    Get.to(const SettingsPage());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      IconlyLight.document,
                      size: 30,
                    ),
                    if (isHover == true)
                      const Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: FittedBox(
                            child: Text("Quran"),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Get.back();
                  Get.to(const SettingsPage());
                },
                icon: const Icon(IconlyLight.setting),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isHover = !isHover;
                  });
                },
                icon: Icon(
                  isHover ? IconlyLight.arrowLeft2 : IconlyLight.arrowRight2,
                ),
              )
            ],
          ),
        ),
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const SurahCardShimmer()
            : ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                children: [
                  for (var item in controller.listOfSurah)
                    FadeInDown(
                      // animate: true,
                      // delay: const Duration(milliseconds: 500),
                      child: InkWell(
                        highlightColor: Colors.white12,
                        splashColor: Colors.white12,
                        onTap: () => Get.to(
                          SurahDetailPage(
                            number: item.number,
                            nameShort: item.name!.arab,
                            revelation: item.revelation!.id,
                            nameTransliteration: item.name!.id,
                            nameTranslation: item.name!.translationId,
                            numberOfVerses: item.numberOfVerses,
                          ),
                        ),
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
