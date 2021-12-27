import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/quran/controller/surah_controller.dart';
import 'package:quran_app/quran/view/widget/surah_item.dart';

class SurahPage extends StatelessWidget {
  SurahPage({Key? key}) : super(key: key);

  final controller = Get.put(SurahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7f8),
      body: GetX<SurahController>(
        builder: (controller) {
          return ListView(
            children: [
              for (var item in controller.listOfSurah)
                SurahItem(
                  number: item.number,
                  nameShort: item.name!.arab,
                  revelation: item.revelation!.id,
                  nameTransliteration: item.name!.id,
                  numberOfVerses: item.numberOfVerses,
                ),
            ],
          );
        },
      ),
    );
  }
}
