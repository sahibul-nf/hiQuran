import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:quran_app/src/widgets/app_shimmer.dart';

class SurahDetailPageShimmer extends StatelessWidget {
  const SurahDetailPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        for (var i = 0; i < 3; i++)
          AppCard(
            color: Theme.of(context).cardColor,
            vMargin: 10,
            vPadding: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  color: Get.isDarkMode
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
                  height: 40,
                ),
                const SizedBox(height: 30),
                AppShimmer(
                  width: MediaQuery.of(context).size.width * 0.8,
                  color: Get.isDarkMode
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
                  height: 20,
                ),
                const SizedBox(height: 10),
                AppShimmer(
                  width: MediaQuery.of(context).size.width * 0.5,
                  color: Get.isDarkMode
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
                  height: 20,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
