import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:quran_app/src/widgets/app_drawer.dart';
import 'package:quran_app/src/widgets/app_permission_status.dart';
import 'package:quran_app/src/widgets/coming_soon_card.dart';
import 'package:unicons/unicons.dart';

import '../controllers/prayer_time_controller.dart';

class PrayerTimePage extends StatelessWidget {
  PrayerTimePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final prayerTimeC = Get.put(PrayerTimeControllerImpl());
  final cT = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "Prayer Times",
          style: AppTextStyle.bigTitle,
        ),
        leading: IconButton(
          onPressed: () => _key.currentState!.openDrawer(),
          icon: const Icon(
            UniconsLine.icons,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          toNextPrayer();
        },
        displacement: 250,
        backgroundColor: Theme.of(context).cardColor,
        color: Theme.of(context).primaryColor,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today",
                style: AppTextStyle.title,
              ),
              const SizedBox(height: 10),
              Obx(() {
                var prayer = prayerTimeC.nextPrayer.value;
                var time = prayerTimeC.prayerTimesToday;
                var address = prayerTimeC.currentAddress;
                int? nextH, nextM;
                var leftOver = 0;

                switch (prayer) {
                  case Prayer.fajr:
                    nextH = time.value.shubuh?.hour;
                    nextM = time.value.shubuh?.minute;
                    leftOver =
                        time.value.shubuh!.difference(DateTime.now()).inSeconds;
                    break;
                  case Prayer.dhuhr:
                    nextH = time.value.dhuhur?.hour;
                    nextM = time.value.dhuhur?.minute;
                    leftOver =
                        time.value.dhuhur!.difference(DateTime.now()).inSeconds;
                    break;
                  case Prayer.asr:
                    nextH = time.value.ashar?.hour;
                    nextM = time.value.ashar?.minute;
                    leftOver =
                        time.value.ashar!.difference(DateTime.now()).inSeconds;
                    break;
                  case Prayer.maghrib:
                    nextH = time.value.maghrib?.hour;
                    nextM = time.value.maghrib?.minute;
                    leftOver = time.value.maghrib!
                        .difference(DateTime.now())
                        .inSeconds;
                    break;
                  case Prayer.isha:
                    nextH = time.value.isya?.hour;
                    nextM = time.value.isya?.minute;
                    leftOver =
                        time.value.isya!.difference(DateTime.now()).inSeconds;
                    break;
                  case Prayer.sunrise:
                    nextH = time.value.sunrise?.hour;
                    nextM = time.value.sunrise?.minute;
                    leftOver = time.value.sunrise!
                        .difference(DateTime.now())
                        .inSeconds;
                    break;
                  case Prayer.none:
                    nextH = time.value.lastThirdOfTheNight?.hour;
                    nextM = time.value.lastThirdOfTheNight?.minute;
                    if (time.value.lastThirdOfTheNight != null) {
                      leftOver = time.value.lastThirdOfTheNight!
                          .difference(DateTime.now())
                          .inSeconds;
                    }
                    break;
                  default:
                }

                if (prayerTimeC.leftOver.value == 0) {
                  prayerTimeC.leftOver.value = leftOver;
                }
                log("LeftOver: $leftOver");
                log("LeftOver Value: ${prayerTimeC.leftOver.value}");

                String hour =
                    nextH != null ? nextH.toString().padLeft(2, '0') : "--";
                String minute =
                    nextM != null ? nextM.toString().padLeft(2, '0') : "--";

                return AppCard(
                  hMargin: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$hour:$minute",
                            style: AppTextStyle.title.copyWith(
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Obx(
                            () => Text.rich(
                              TextSpan(
                                text: (prayerTimeC.nextPrayer.value.name ==
                                        "none")
                                    ? "Qiyam"
                                    : prayerTimeC
                                        .nextPrayer.value.name.capitalizeFirst,
                                children: [
                                  const TextSpan(text: " - "),
                                  TextSpan(
                                    text: address.isBlank!
                                        ? ""
                                        : address.value.country,
                                    style: AppTextStyle.normal.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              style: AppTextStyle.normal,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                UniconsLine.user_location,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${address.value.subLocality ?? "--"},",
                                    style: AppTextStyle.small.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    address.value.locality ?? "--",
                                    style: AppTextStyle.small.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Obx(() {
                        if (prayerTimeC.leftOver.value == 0) {
                          return const SizedBox();
                        }

                        return CircularCountDownTimer(
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: MediaQuery.of(context).size.width * 0.18,
                          duration: prayerTimeC.leftOver.value,
                          controller: cT,
                          fillColor: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          ringColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          // strokeWidth: 20.0,
                          strokeCap: StrokeCap.round,
                          textStyle: AppTextStyle.small.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          isReverse: true,
                          onComplete: () {
                            prayerTimeC.leftOver.value = 0;
                            log("--- Now is ${prayerTimeC.currentPrayer} time ---");
                            toNextPrayer();
                            cT.restart(duration: prayerTimeC.leftOver.value);
                          },
                        );
                      }),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              Obx(() {
                var time = prayerTimeC.prayerTimesToday.value;
                var shubuh = time.shubuh;
                var sunrise = time.sunrise;
                var dhuhur = time.dhuhur;
                var ashar = time.ashar;
                var maghrib = time.maghrib;
                var isya = time.isya;
                var lastThirdOfTheNight = time.lastThirdOfTheNight;

                List<DateTime?> prayerTimes = [
                  shubuh,
                  sunrise,
                  dhuhur,
                  ashar,
                  maghrib,
                  isya,
                  lastThirdOfTheNight,
                ];

                List prayerNames = [
                  Prayer.fajr.name.capitalize,
                  Prayer.sunrise.name.capitalize,
                  Prayer.dhuhr.name.capitalize,
                  Prayer.asr.name.capitalize,
                  Prayer.maghrib.name.capitalize,
                  Prayer.isha.name.capitalize,
                  "Qiyam",
                ];

                return AppCard(
                  hMargin: 0,
                  child: Column(
                    children: [
                      for (var i = 0; i <= 6; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${prayerTimes[i]?.hour.toString().padLeft(2, '0') ?? "--"}:${prayerTimes[i]?.minute.toString().padLeft(2, '0') ?? "--"}",
                                  style: AppTextStyle.normal.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Chip(
                                  labelPadding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  label: Text(
                                    prayerNames[i],
                                    style: AppTextStyle.small.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "${prayerTimes[i]?.day.toString().padLeft(2, '0') ?? "--"}/${prayerTimes[i]?.month.toString().padLeft(2, '0') ?? "--"}/${prayerTimes[i]?.year ?? "--"}",
                                  style: AppTextStyle.small.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(ComingSoonCard());
                                  },
                                  icon: const Icon(
                                    UniconsLine.volume_mute,
                                  ),
                                )
                              ],
                            ),
                            if (i != 6) const Divider(),
                          ],
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void toNextPrayer() async {
    final handlePermission = await prayerTimeC.handleLocationPermission();

    if (!handlePermission.result) {
      Get.bottomSheet(AppPermissionStatus(
        message: handlePermission.error.toString(),
      ));
    } else {
      var location = prayerTimeC.currentLocation.value;
      prayerTimeC.getPrayerTimesToday(
        location.latitude,
        location.longitude,
      );
    }
  }
}
