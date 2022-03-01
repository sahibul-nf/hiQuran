import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [AppShadow.card],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Chip(
                backgroundColor: Theme.of(context).cardColor,
                label: Text(
                  "$revelation",
                  style: AppTextStyle.small,
                ),
              ),
              const SizedBox(width: 8),
              Chip(
                backgroundColor: Theme.of(context).cardColor,
                label: Text(
                  "$numberOfVerses Ayat",
                  style: AppTextStyle.small,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
