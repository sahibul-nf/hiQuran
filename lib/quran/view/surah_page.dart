import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/quran/controller/surah_controller.dart';
import 'package:quran_app/quran/view/widget/surah_item.dart';
import 'package:quran_app/utils/theme.dart';

class SurahPage extends StatelessWidget {
  SurahPage({Key? key}) : super(key: key);

  final controller = Get.put(SurahController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quran"),
        centerTitle: true,
      ),
      body: GetX<SurahController>(
        builder: (controller) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
