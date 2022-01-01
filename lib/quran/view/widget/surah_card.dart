import 'package:flutter/material.dart';
import 'package:quran_app/utils/theme.dart';

class SurahCard extends StatelessWidget {
  const SurahCard({
    Key? key,
    this.number,
    this.nameTransliteration,
    this.revelation,
    this.nameShort,
    this.numberOfVerses,
    this.nameTranslation,
  }) : super(key: key);
  final int? number;
  final String? nameTransliteration;
  final String? nameTranslation;
  final String? revelation;
  final String? nameShort;
  final int? numberOfVerses;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: ColorPalletes.bgColor,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [AppShadow.card],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: ColorPalletes.sapphire.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "$number",
                style: AppTextStyle.normal.copyWith(
                  color: ColorPalletes.sapphire,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$nameTransliteration",
            style: AppTextStyle.title.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            "$nameTranslation",
            style: AppTextStyle.normal.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$revelation",
                style: AppTextStyle.small,
              ),
              Text(
                " - $numberOfVerses Verses",
                style: AppTextStyle.small,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
