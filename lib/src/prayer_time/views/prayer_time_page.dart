import 'dart:developer';

import 'package:adhan/adhan.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:quran_app/services/notification_service.dart';
import 'package:quran_app/src/prayer_time/controllers/prayer_time_notif_controller.dart';
import 'package:quran_app/src/prayer_time/widgets/prayer_time_card.dart';
import 'package:quran_app/src/prayer_time/widgets/prayer_time_page_shimmer.dart';
import 'package:quran_app/src/prayer_time/widgets/select_time.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';

import '../controllers/prayer_time_controller.dart';

class PrayerTimePage extends StatelessWidget {
  PrayerTimePage({Key? key}) : super(key: key);

  // final GlobalKey<ScaffoldState> _key = GlobalKey();

  final prayerTimeC = Get.put(PrayerTimeControllerImpl());
  final prayerTimeNotifC = Get.put(PrayerTimeNotifController());

  final groupBtnController = GroupButtonController(
      // selectedIndex: 0,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _key,
      // drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "Prayer Times",
          style: AppTextStyle.bigTitle,
        ),
        // leading: IconButton(
        //   onPressed: () => _key.currentState!.openDrawer(),
        //   icon: const Icon(
        //     UniconsLine.icons,
        //     color: Colors.white,
        //   ),
        // ),
        centerTitle: true,
        elevation: 1,
      ),
      // ! Fix: connectifity
      //       decoration: BoxDecoration(
      //   boxShadow: [AppShadow.card],
      //   color: ColorPalletes.frenchPink.withOpacity(0.2),
      // ),
      // messageStyle: AppTextStyle.small.copyWith(
      //   color: ColorPalletes.frenchPink,
      //   fontWeight: FontWeight.w600,
      //   letterSpacing: 0.5,
      // ),
      // alignment: Alignment.topCenter,

      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          toNextPrayer();
        },
        backgroundColor: Theme.of(context).cardColor,
        color: Theme.of(context).primaryColor,
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: Obx(() {
          return prayerTimeC.isLoadLocation.value
              ? const SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: PrayerTimePageShimmer(),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    physics: const AlwaysScrollableScrollPhysics(),

                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today",
                        style: AppTextStyle.title,
                      ),
                      const SizedBox(height: 10),
                      Hero(
                        tag: 'prayer_time_card',
                        child: PrayerTimeCard(prayerTimeC: prayerTimeC),
                      ),
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

                        List<bool> enableNotif = [
                          prayerTimeNotifC.enableFajr.value,
                          prayerTimeNotifC.enableSunrise.value,
                          prayerTimeNotifC.enableDhuhr.value,
                          prayerTimeNotifC.enableAsr.value,
                          prayerTimeNotifC.enableMaghrib.value,
                          prayerTimeNotifC.enableIsha.value,
                          prayerTimeNotifC.enableQiyam.value,
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

                        return FadeInDown(
                          from: 40,
                          child: AppCard(
                            hMargin: 0,
                            child: SizedBox(
                              height: 432,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            const EdgeInsets.symmetric(
                                                horizontal: 8),
                                        backgroundColor: Get.isDarkMode
                                            ? Theme.of(context)
                                                .cardColor
                                                .withOpacity(0.7)
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.1),
                                        label: Text(
                                          prayerNames[i],
                                          style: AppTextStyle.small.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                          groupBtnController.unselectAll();

                                          switch (i) {
                                            case 0:
                                              if (prayerTimeNotifC
                                                  .enableFajr.isTrue) {
                                                cancelScheduleNotification(
                                                  prayerTimeNotifC.fajrId.value,
                                                  "fajr",
                                                ).then((_) {
                                                  // Change notif icon
                                                  prayerTimeNotifC
                                                          .enableFajr.value =
                                                      !prayerTimeNotifC
                                                          .enableFajr.value;

                                                  // save to local db
                                                  prayerTimeNotifC.writeBox(
                                                    key: 'fajr_notif',
                                                    value: prayerTimeNotifC
                                                        .enableFajr.value
                                                        .toString(),
                                                  );
                                                });
                                              } else {
                                                showSetPrayerTime(
                                                  prayerTime: prayerTimes[0]!,
                                                  prayerName: prayerNames[0],
                                                );
                                              }

                                              break;
                                            case 1:
                                              if (prayerTimeNotifC
                                                  .enableSunrise.isTrue) {
                                                cancelScheduleNotification(
                                                  prayerTimeNotifC
                                                      .sunriseId.value,
                                                  "sunrise",
                                                ).then((_) {
                                                  // Change notif icon
                                                  prayerTimeNotifC
                                                          .enableSunrise.value =
                                                      !prayerTimeNotifC
                                                          .enableSunrise.value;

                                                  prayerTimeNotifC.writeBox(
                                                    key: 'sunrise_notif',
                                                    value: prayerTimeNotifC
                                                        .enableSunrise.value
                                                        .toString(),
                                                  );
                                                });
                                              } else {
                                                showSetPrayerTime(
                                                  prayerTime: prayerTimes[1]!,
                                                  prayerName: prayerNames[1],
                                                );
                                              }

                                              break;
                                            case 2:
                                              if (prayerTimeNotifC
                                                  .enableDhuhr.isTrue) {
                                                cancelScheduleNotification(
                                                  prayerTimeNotifC
                                                      .dhuhrId.value,
                                                  "dhuhr",
                                                ).then((_) {
                                                  // Change notif icon
                                                  prayerTimeNotifC
                                                          .enableDhuhr.value =
                                                      !prayerTimeNotifC
                                                          .enableDhuhr.value;

                                                  prayerTimeNotifC.writeBox(
                                                    key: 'dhuhr_notif',
                                                    value: prayerTimeNotifC
                                                        .enableDhuhr.value
                                                        .toString(),
                                                  );
                                                });
                                              } else {
                                                showSetPrayerTime(
                                                  prayerTime: prayerTimes[2]!,
                                                  prayerName: prayerNames[2],
                                                );
                                              }

                                              break;
                                            case 3:
                                              if (prayerTimeNotifC
                                                  .enableAsr.isTrue) {
                                                cancelScheduleNotification(
                                                  prayerTimeNotifC.asrId.value,
                                                  "asr",
                                                ).then((_) {
                                                  // Change notif icon
                                                  prayerTimeNotifC
                                                          .enableAsr.value =
                                                      !prayerTimeNotifC
                                                          .enableAsr.value;

                                                  prayerTimeNotifC.writeBox(
                                                    key: 'asr_notif',
                                                    value: prayerTimeNotifC
                                                        .enableAsr.value
                                                        .toString(),
                                                  );
                                                });
                                              } else {
                                                showSetPrayerTime(
                                                  prayerTime: prayerTimes[3]!,
                                                  prayerName: prayerNames[3],
                                                );
                                              }

                                              break;
                                            case 4:
                                              if (prayerTimeNotifC
                                                  .enableMaghrib.isTrue) {
                                                cancelScheduleNotification(
                                                  prayerTimeNotifC
                                                      .maghribId.value,
                                                  "maghrib",
                                                ).then((_) {
                                                  // Change notif icon
                                                  prayerTimeNotifC
                                                          .enableMaghrib.value =
                                                      !prayerTimeNotifC
                                                          .enableMaghrib.value;

                                                  prayerTimeNotifC.writeBox(
                                                    key: 'maghrib_notif',
                                                    value: prayerTimeNotifC
                                                        .enableMaghrib.value
                                                        .toString(),
                                                  );
                                                });
                                              } else {
                                                showSetPrayerTime(
                                                  prayerTime: prayerTimes[4]!,
                                                  prayerName: prayerNames[4],
                                                );
                                              }

                                              break;
                                            case 5:
                                              if (prayerTimeNotifC
                                                  .enableIsha.isTrue) {
                                                cancelScheduleNotification(
                                                  prayerTimeNotifC.ishaId.value,
                                                  "isha",
                                                ).then((_) {
                                                  // Change notif icon
                                                  prayerTimeNotifC
                                                          .enableIsha.value =
                                                      !prayerTimeNotifC
                                                          .enableIsha.value;

                                                  prayerTimeNotifC.writeBox(
                                                    key: 'isha_notif',
                                                    value: prayerTimeNotifC
                                                        .enableIsha.value
                                                        .toString(),
                                                  );
                                                });
                                              } else {
                                                showSetPrayerTime(
                                                  prayerTime: prayerTimes[5]!,
                                                  prayerName: prayerNames[5],
                                                );
                                              }

                                              break;
                                            case 6:
                                              if (prayerTimeNotifC
                                                  .enableQiyam.isTrue) {
                                                cancelScheduleNotification(
                                                  prayerTimeNotifC
                                                      .qiyamId.value,
                                                  "qiyam",
                                                ).then((_) {
                                                  // Change notif icon
                                                  prayerTimeNotifC
                                                          .enableQiyam.value =
                                                      !prayerTimeNotifC
                                                          .enableQiyam.value;

                                                  prayerTimeNotifC.writeBox(
                                                    key: 'qiyam_notif',
                                                    value: prayerTimeNotifC
                                                        .enableQiyam.value
                                                        .toString(),
                                                  );
                                                });
                                              } else {
                                                showSetPrayerTime(
                                                  prayerTime: prayerTimes[6]!,
                                                  prayerName: prayerNames[6],
                                                );
                                              }

                                              break;
                                            default:
                                          }
                                        },
                                        icon: Icon(
                                          enableNotif[i]
                                              ? Icons
                                                  .notifications_active_outlined
                                              : Icons
                                                  .notifications_off_outlined,
                                          color: enableNotif[i]
                                              ? null
                                              : Colors.grey,
                                        ),
                                      )
                                    ],
                                  );
                                },
                                separatorBuilder: (context, i) {
                                  return const Divider();
                                },
                                itemCount: prayerTimes.length,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
        }),
      ),
    );
  }

  void toNextPrayer() {
    prayerTimeC.getLocation().then((_) {
      prayerTimeC.cT.restart(duration: prayerTimeC.leftOver.value);
    });
  }

  void showSetPrayerTime(
      {required DateTime prayerTime, required String prayerName}) {
    int? hour, minute;

    log(prayerName);

    Get.bottomSheet(
      SelectTime(
        controller: groupBtnController,
        onSelected: (value, index, selected) {
          debugPrint("$value $index $selected");

          switch (index) {
            case 0:
              hour = 0;
              minute = 0; // in second
              break;
            case 1:
              hour = 0;
              minute = 300; // in second
              break;
            case 2:
              hour = 0;
              minute = 600; // in second
              break;
            case 3:
              hour = 0;
              minute = 900; // in second
              break;
            case 4:
              hour = 0;
              minute = 1200; // in second
              break;

            default:
          }
        },
        onPressed: () {
          activeScheduleNotification(hour, minute, prayerTime, prayerName);
        },
      ),
    );
  }

  void activeScheduleNotification(
      int? hour, int? minute, DateTime prayerTime, String prayerName) {
    if (hour != null || minute != null) {
      log("ACTIVE SCHEDULE ${prayerName.toUpperCase()}");

      prayerTimeNotifC.createPrayerTimeReminder(
        prayerTime: prayerName,
        dateTime: prayerTime,
        hour: hour!,
        minute: minute!,
      );

      if (prayerName == 'Fajr') {
        // Change notif icon
        prayerTimeNotifC.enableFajr.value = !prayerTimeNotifC.enableFajr.value;

        // save to local db
        prayerTimeNotifC.writeBox(
          key: 'fajr_notif',
          value: prayerTimeNotifC.enableFajr.value.toString(),
        );
      } else if (prayerName == 'Sunrise') {
        // Change notif icon
        prayerTimeNotifC.enableSunrise.value =
            !prayerTimeNotifC.enableSunrise.value;

        prayerTimeNotifC.writeBox(
          key: 'sunrise_notif',
          value: prayerTimeNotifC.enableSunrise.value.toString(),
        );
      } else if (prayerName == 'Dhuhr') {
        // Change notif icon
        prayerTimeNotifC.enableDhuhr.value =
            !prayerTimeNotifC.enableDhuhr.value;

        prayerTimeNotifC.writeBox(
          key: 'dhuhr_notif',
          value: prayerTimeNotifC.enableDhuhr.value.toString(),
        );
      } else if (prayerName == 'Asr') {
        // Change notif icon
        prayerTimeNotifC.enableAsr.value = !prayerTimeNotifC.enableAsr.value;

        prayerTimeNotifC.writeBox(
          key: 'asr_notif',
          value: prayerTimeNotifC.enableAsr.value.toString(),
        );
      } else if (prayerName == 'Maghrib') {
        // Change notif icon
        prayerTimeNotifC.enableMaghrib.value =
            !prayerTimeNotifC.enableMaghrib.value;

        prayerTimeNotifC.writeBox(
          key: 'maghrib_notif',
          value: prayerTimeNotifC.enableMaghrib.value.toString(),
        );
      } else if (prayerName == 'Isha') {
        // Change notif icon
        prayerTimeNotifC.enableIsha.value = !prayerTimeNotifC.enableIsha.value;

        prayerTimeNotifC.writeBox(
          key: 'isha_notif',
          value: prayerTimeNotifC.enableIsha.value.toString(),
        );
      } else if (prayerName == 'Qiyam') {
        // Change notif icon
        prayerTimeNotifC.enableQiyam.value =
            !prayerTimeNotifC.enableQiyam.value;

        prayerTimeNotifC.writeBox(
          key: 'qiyam_notif',
          value: prayerTimeNotifC.enableQiyam.value.toString(),
        );
      }

      Get.back();
    } else {
      Get.back();
      Get.snackbar("Opps...",
          "Set prayer times reminder to activate reminder notification.");
    }
  }

  Future<void> cancelScheduleNotification(int id, String prayerName) async {
    if (id != 0) {
      log("CANCEL SCHEDULE ${prayerName.toUpperCase()}");
      await AwesomeNotify.cancelScheduledNotificationById(
        id,
      );
    }
  }
}
