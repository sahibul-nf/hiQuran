import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:quran_app/src/widgets/app_shimmer.dart';

class ArticleCardShimmer extends StatelessWidget {
  const ArticleCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppShimmer(
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.grey.shade100,
                height: 30,
                width: 30,
                radius: 50,
              ),
              const SizedBox(width: 16),
              AppShimmer(
                color: Get.isDarkMode
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.grey.shade100,
                height: 16,
                width: MediaQuery.of(context).size.width / 3,
                radius: 50,
              ),
            ],
          ),
          const SizedBox(height: 20),
          AppShimmer(
            color: Get.isDarkMode
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.grey.shade100,
            height: 20,
            width: MediaQuery.of(context).size.width * 0.7,
            radius: 50,
          ),
          const SizedBox(height: 8),
          AppShimmer(
            color: Get.isDarkMode
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.grey.shade100,
            height: 20,
            width: MediaQuery.of(context).size.width * 0.4,
            radius: 50,
          ),
          const SizedBox(height: 20),
          AppShimmer(
            color: Get.isDarkMode
                ? Theme.of(context).primaryColor.withOpacity(0.1)
                : Colors.grey.shade100,
            height: 190,
            width: MediaQuery.of(context).size.width,
            radius: 25,
          ),
        ],
      ),
    );
  }
}
