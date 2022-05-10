import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_card.dart';
import '../../widgets/app_shimmer.dart';

class PrayerTimePageShimmer extends StatelessWidget {
  const PrayerTimePageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
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
                      color:
                          Get.isDarkMode ? Colors.grey : Colors.grey.shade100,
                      height: 20,
                      width: MediaQuery.of(context).size.width / 4,
                      radius: 50,
                    ),
                    const SizedBox(height: 10),
                    AppShimmer(
                      color:
                          Get.isDarkMode ? Colors.grey : Colors.grey.shade100,
                      height: 20,
                      width: MediaQuery.of(context).size.width / 2.5,
                      radius: 50,
                    ),
                    const SizedBox(height: 20),
                    AppShimmer(
                      color:
                          Get.isDarkMode ? Colors.grey : Colors.grey.shade100,
                      height: 20,
                      width: MediaQuery.of(context).size.width / 2,
                      radius: 50,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              AppShimmer(
                color: Get.isDarkMode ? Colors.grey : Colors.grey.shade100,
                height: MediaQuery.of(context).size.width * 0.18,
                width: MediaQuery.of(context).size.width * 0.18,
                radius: 50,
              ),
            ],
          ),
        ),
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
                                ? Colors.grey
                                : Colors.grey.shade100,
                            height: 30,
                            width: MediaQuery.of(context).size.width / 5,
                            radius: 50,
                          ),
                          const SizedBox(width: 10),
                          AppShimmer(
                            color: Get.isDarkMode
                                ? Colors.grey
                                : Colors.grey.shade100,
                            height: 30,
                            width: MediaQuery.of(context).size.width / 7,
                            radius: 50,
                          ),
                          const SizedBox(width: 50),
                          Flexible(
                            child: AppShimmer(
                              color: Get.isDarkMode
                                  ? Colors.grey
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
