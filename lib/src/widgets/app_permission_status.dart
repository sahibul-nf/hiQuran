import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/my_outline_button.dart';
import 'package:quran_app/src/prayer_time/controllers/prayer_time_controller.dart';
import 'package:unicons/unicons.dart';

import '../../bricks/my_widgets/my_button.dart';
import '../settings/theme/app_theme.dart';

class AppPermissionStatus extends StatelessWidget {
  final String message;
  const AppPermissionStatus({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [AppShadow.card],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              UniconsLine.map_marker_slash,
              size: 90,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Opps...",
            style: AppTextStyle.title.copyWith(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              message,
              style: AppTextStyle.small.copyWith(
                color: Colors.grey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // const Spacer(),
          const SizedBox(height: 20),
          MyButton(
            text: "Allow Permission",
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              final prayerC = Get.find<PrayerTimeControllerImpl>();
              prayerC.openAppSetting().then((value) {
                if (!value) {
                  Get.snackbar("Opps", "Cannot open setting");
                }
              });
            },
          ),
          const SizedBox(height: 10),
          MyOutlinedButton(
            text: "Later",
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              // Get.back();
              
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
