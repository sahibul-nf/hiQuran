import 'package:flutter/material.dart';
import 'package:quran_app/quran/view/widget/surah_card.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class SurahDetailPage extends StatelessWidget {
  const SurahDetailPage(
      {Key? key,
      this.number,
      this.nameTransliteration,
      this.nameTranslation,
      this.revelation,
      this.nameShort,
      this.numberOfVerses})
      : super(key: key);
  final int? number;
  final String? nameTransliteration;
  final String? nameTranslation;
  final String? revelation;
  final String? nameShort;
  final int? numberOfVerses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SahibulQuran",
          style: AppTextStyle.bigTitle.copyWith(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SurahCard(
              number: number,
              nameShort: "$nameShort",
              nameTranslation: "$nameTranslation",
              nameTransliteration: "$nameTransliteration",
              numberOfVerses: numberOfVerses,
              revelation: "$revelation",
            ),
          ],
        ),
      ),
    );
  }
}
