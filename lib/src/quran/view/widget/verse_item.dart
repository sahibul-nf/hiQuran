import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class VerseItem extends StatelessWidget {
  const VerseItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "nameTransliteration",
                style: AppTextStyle.title.copyWith(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "nameTranslation",
            style: AppTextStyle.normal.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
