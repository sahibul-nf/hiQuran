import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/prayer_time/controllers/prayer_time_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:unicons/unicons.dart';

class PrayerTimeCard extends StatelessWidget {
  const PrayerTimeCard({Key? key, required this.prayerTimeC}) : super(key: key);
  final PrayerTimeControllerImpl prayerTimeC;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(25),
      child: Obx(() {
        var prayer = prayerTimeC.nextPrayer.value;
        var time = prayerTimeC.prayerTimesToday;
        var address = prayerTimeC.currentAddress;
        int? nextH, nextM;
        var leftOver = 0;
        var duration = 0;
        int initDuration = 0;

        switch (prayer) {
          case Prayer.fajr:
            nextH = time.value.shubuh?.hour;
            nextM = time.value.shubuh?.minute;
            leftOver = time.value.shubuh!.difference(DateTime.now()).inSeconds;
            duration = time.value.lastThirdOfTheNight!
                .difference(time.value.shubuh!)
                .inSeconds;
            break;
          case Prayer.dhuhr:
            nextH = time.value.dhuhur?.hour;
            nextM = time.value.dhuhur?.minute;
            leftOver = time.value.dhuhur!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.sunrise!.difference(time.value.dhuhur!).inSeconds;

            break;
          case Prayer.asr:
            nextH = time.value.ashar?.hour;
            nextM = time.value.ashar?.minute;
            leftOver = time.value.ashar!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.dhuhur!.difference(time.value.ashar!).inSeconds;

            break;
          case Prayer.maghrib:
            nextH = time.value.maghrib?.hour;
            nextM = time.value.maghrib?.minute;
            leftOver = time.value.maghrib!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.ashar!.difference(time.value.maghrib!).inSeconds;

            break;
          case Prayer.isha:
            nextH = time.value.isya?.hour;
            nextM = time.value.isya?.minute;
            leftOver = time.value.isya!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.maghrib!.difference(time.value.isya!).inSeconds;

            break;
          case Prayer.sunrise:
            nextH = time.value.sunrise?.hour;
            nextM = time.value.sunrise?.minute;
            leftOver = time.value.sunrise!.difference(DateTime.now()).inSeconds;
            duration =
                time.value.shubuh!.difference(time.value.sunrise!).inSeconds;

            break;
          case Prayer.none:
            nextH = time.value.lastThirdOfTheNight?.hour;
            nextM = time.value.lastThirdOfTheNight?.minute;
            if (time.value.lastThirdOfTheNight != null) {
              leftOver = time.value.lastThirdOfTheNight!
                  .difference(DateTime.now())
                  .inSeconds;
              duration = time.value.isya!
                  .difference(time.value.lastThirdOfTheNight!)
                  .inSeconds;
            }
            break;
          default:
        }

        if (prayerTimeC.leftOver.value == 0) {
          prayerTimeC.leftOver.value = leftOver;
        }

        // convert negative value to positive
        if (duration.isNegative) duration = duration * -1;

        if (initDuration < duration) {
          initDuration = duration - (leftOver - 0);
        }

        if (initDuration > duration) initDuration = duration;

        if (initDuration == duration) {
          initDuration = duration - leftOver;
        }

        log("Duration: $duration $prayer");
        log("LeftOver Value: ${prayerTimeC.leftOver.value}");
        log("InitDuration: $initDuration");

        String hour = nextH != null ? nextH.toString().padLeft(2, '0') : "--";
        String minute = nextM != null ? nextM.toString().padLeft(2, '0') : "--";

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
                        text: (nextH != null &&
                                prayerTimeC.nextPrayer.value.name == "none")
                            ? "Qiyam"
                            : (nextH == null)
                                ? ""
                                : prayerTimeC
                                    .nextPrayer.value.name.capitalizeFirst,
                        children: [
                          const TextSpan(text: " - "),
                          TextSpan(
                            text: address.isBlank! ? "" : address.value.country,
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
              CircularCountDownTimer(
                width: MediaQuery.of(context).size.width * 0.18,
                height: MediaQuery.of(context).size.width * 0.18,
                duration: duration,
                initialDuration: initDuration,
                controller: prayerTimeC.cT,
                fillColor: Theme.of(context).primaryColor,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.2),
                ringColor: Theme.of(context).primaryColor.withOpacity(0.1),
                // strokeWidth: 20.0,
                strokeCap: StrokeCap.round,
                textStyle: AppTextStyle.small.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),

                isReverse: true,
                onComplete: () async {
                  prayerTimeC.leftOver.value = 0;
                  log("--- Now is ${prayerTimeC.nextPrayer} time ---");

                  await Future.delayed(2.seconds);

                  // to Next Prayer
                  prayerTimeC.getLocation().then((_) {
                    prayerTimeC.cT
                        .restart(duration: prayerTimeC.leftOver.value);
                  });
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
