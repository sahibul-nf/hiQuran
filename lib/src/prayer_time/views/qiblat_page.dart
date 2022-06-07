import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/prayer_time/controllers/prayer_time_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_loading.dart';

class QiblatPage extends StatelessWidget {
  QiblatPage({Key? key}) : super(key: key);

  final _prayerTimeC = Get.put(PrayerTimeControllerImpl());

  @override
  Widget build(BuildContext context) {
    _prayerTimeC.checkDeviceSensorSupport();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Qiblah",
          style: AppTextStyle.bigTitle,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body:
          // FutureBuilder(
          //     future: _prayerTimeC.checkDeviceSensorSupport(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const AppLoading();
          //       }

          // return
          Obx(
        () => !_prayerTimeC.isQiblahLoaded.value
            ? const AppLoading()
            : (_prayerTimeC.sensorIsSupported.value)
                ? StreamBuilder(
                    stream: FlutterQiblah.qiblahStream,
                    builder:
                        (context, AsyncSnapshot<QiblahDirection> snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }

                      final qiblahDirection = snapshot.data;

                      double direction =
                          ((qiblahDirection?.direction ?? 0) * (pi / 180) * -1);

                      double qiblah =
                          ((qiblahDirection?.qiblah ?? 0) * (pi / 180) * -1);
                      // String offset = qiblahDirection!.offset.toStringAsFixed(2);

                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // const SizedBox(height: 70),
                            Obx(
                              () => Text(
                                // "Qiblah\n"
                                "🎯\n"
                                "${_prayerTimeC.qiblahDirection.value.toStringAsFixed(0)}°",
                                style: AppTextStyle.bigTitle.copyWith(
                                  fontSize: 24,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 70),
                            FadeIn(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Transform.rotate(
                                          // origin: Offset.fromDirection(direction),
                                          angle: direction,
                                          child: SvgPicture.asset(
                                            "assets/illustration/compass.svg",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Transform.rotate(
                                      // origin: Offset.fromDirection(direction),
                                      angle: qiblah,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          FadeIn(
                                            child: Image.asset(
                                              "assets/illustration/3D-Kaaba.png",
                                              width: 60,
                                              cacheHeight: 200,
                                              cacheWidth: 200,
                                            ),
                                          ),
                                          Container(
                                            height: 300,
                                            width: 8,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: const [
                                                  0.1,
                                                  0.5,
                                                ],
                                                colors: [
                                                  Get.isDarkMode
                                                      ? Colors.white
                                                      : Colors.black
                                                          .withOpacity(.5),
                                                  Colors.white.withOpacity(0.0),
                                                ],
                                              ),
                                              // color: Theme.of(context).primaryColor.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("This platform is not supported"),
                  ),
      ),
      // }),
    );
  }
}
