import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:quran_app/src/widgets/app_shimmer.dart';

class SurahCardShimmer extends StatelessWidget {
  const SurahCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        for (var i = 0; i < 7; i++)
          AppCard(
            vMargin: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  color: Get.isDarkMode ? Colors.grey : Colors.grey.shade100,
                  height: 45,
                  width: 45,
                  radius: 50,
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmer(
                        color:
                            Get.isDarkMode ? Colors.grey : Colors.grey.shade100,
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        radius: 50,
                      ),
                      const SizedBox(height: 10),
                      AppShimmer(
                        color:
                            Get.isDarkMode ? Colors.grey : Colors.grey.shade100,
                        height: 20,
                        width: MediaQuery.of(context).size.width / 3,
                        radius: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
