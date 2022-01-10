import 'package:flutter/material.dart';
import 'package:quran_app/src/widgets/app_shimmer.dart';

class SurahCardShimmer extends StatelessWidget {
  const SurahCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        for (var i = 0; i < 7; i++)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: AppShimmer(
              height: 70,
            ),
          )
      ],
    );
  }
}
