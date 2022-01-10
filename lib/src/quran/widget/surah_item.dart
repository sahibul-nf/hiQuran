import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class SurahItem extends StatelessWidget {
  SurahItem({
    Key? key,
    this.number,
    this.nameTransliteration,
    this.revelation,
    this.nameShort,
    this.numberOfVerses,
  }) : super(key: key);
  final int? number;
  final String? nameTransliteration;
  final String? revelation;
  final String? nameShort;
  final int? numberOfVerses;

  final controller = Get.find<SurahController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppShadow.card],
      ),
      constraints: BoxConstraints(maxWidth: size.width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        "$number",
                        style: AppTextStyle.normal.copyWith(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$nameTransliteration", style: AppTextStyle.title),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          "$revelation",
                          style: AppTextStyle.small,
                        ),
                        Text(
                          " - $numberOfVerses Ayat",
                          style: AppTextStyle.small,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "$nameShort",
            textAlign: TextAlign.right,
            style: AppTextStyle.title.copyWith(
              fontFamily: "Noorehira",
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
