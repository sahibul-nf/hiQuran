import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/prayer_time/widgets/prayer_time_card_shimmer.dart';

import '../../widgets/app_card.dart';
import '../../widgets/app_shimmer.dart';

class PrayerTimePageShimmer extends StatelessWidget {
  const PrayerTimePageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PrayerTimeCardShimmer(),
        const SizedBox(width: 20),
        AppCard(
          vMargin: 10,
          hMargin: 0,
          child: Column(
            children: [
              for (var i = 0; i < 8; i++)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmer(
                            color: Get.isDarkMode
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.grey.shade100,
                            height: 30,
                            width: MediaQuery.of(context).size.width / 5,
                            radius: 50,
                          ),
                          const SizedBox(width: 10),
                          AppShimmer(
                            color: Get.isDarkMode
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1)
                                : Colors.grey.shade100,
                            height: 30,
                            width: MediaQuery.of(context).size.width / 7,
                            radius: 50,
                          ),
                          const SizedBox(width: 50),
                          Flexible(
                            child: AppShimmer(
                              color: Get.isDarkMode
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1)
                                  : Colors.grey.shade100,
                              height: 30,
                              width: MediaQuery.of(context).size.width / 3,
                              radius: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (i != 7) const Divider(),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
