import 'package:flutter/material.dart';
import 'package:quran_app/utils/theme.dart';

class SurahItem extends StatelessWidget {
  const SurahItem(
      {Key? key,
      this.number,
      this.nameTransliteration,
      this.revelation,
      this.nameShort,
      this.numberOfVerses})
      : super(key: key);
  final int? number;
  final String? nameTransliteration;
  final String? revelation;
  final String? nameShort;
  final int? numberOfVerses;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      // height: 70,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: ColorPalletes.bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [AppShadow.card],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
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
                          " - $numberOfVerses Verses",
                          style: AppTextStyle.small,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text("$nameShort", style: AppTextStyle.title),
        ],
      ),
    );
  }
}
