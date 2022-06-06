import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:quran_app/src/widgets/app_shimmer.dart';

class SurahCardShimmer extends StatelessWidget {
  const SurahCardShimmer({Key? key, this.amount = 7}) : super(key: key);
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        for (var i = 0; i < amount; i++)
          AppCard(
            vMargin: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  color: Get.isDarkMode
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
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
                        color: Get.isDarkMode
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.grey.shade100,
                        height: 20,
                        width: MediaQuery.of(context).size.width,
                        radius: 50,
                      ),
                      const SizedBox(height: 10),
                      AppShimmer(
                        color: Get.isDarkMode
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.grey.shade100,
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
