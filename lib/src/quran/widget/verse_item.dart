import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class VerseItem extends StatelessWidget {
  const VerseItem({
    Key? key,
    this.textArab,
    this.textTranslation,
    this.numberInSurah,
    this.textTransliteration,
    required this.onTapSeeTafsir,
  }) : super(key: key);
  final String? textArab;
  final String? textTranslation;
  final int? numberInSurah;
  final String? textTransliteration;
  final void Function() onTapSeeTafsir;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppShadow.card],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: FittedBox(
                child: Text(
                  "$numberInSurah",
                  style: AppTextStyle.normal.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                "$textArab",
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Uthmani",
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "$textTransliteration",
            style: AppTextStyle.normal.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "$textTranslation",
            style: AppTextStyle.normal.copyWith(fontSize: 14),
            textAlign: TextAlign.start,
          ),
          InkWell(
            onTap: onTapSeeTafsir,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [AppShadow.card],
              ),
              child: Center(
                child: Text(
                  "See Tafsir",
                  style: AppTextStyle.normal.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
