import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:quran_app/src/widgets/app_shimmer.dart';

class PrayerTimeCardShimmer extends StatelessWidget {
  const PrayerTimeCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      vMargin: 10,
      hMargin: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmer(
                  color: Get.isDarkMode
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
                  height: 20,
                  width: MediaQuery.of(context).size.width / 4,
                  radius: 50,
                ),
                const SizedBox(height: 10),
                AppShimmer(
                  color: Get.isDarkMode
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
                  height: 20,
                  width: MediaQuery.of(context).size.width / 2.5,
                  radius: 50,
                ),
                const SizedBox(height: 20),
                AppShimmer(
                  color: Get.isDarkMode
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey.shade100,
                  height: 20,
                  width: MediaQuery.of(context).size.width / 2,
                  radius: 50,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          AppShimmer(
            color: Get.isDarkMode
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.grey.shade100,
            height: MediaQuery.of(context).size.width * 0.18,
            width: MediaQuery.of(context).size.width * 0.18,
            radius: 50,
          ),
        ],
      ),
    );
  }
}
