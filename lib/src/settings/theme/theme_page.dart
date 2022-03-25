import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:unicons/unicons.dart';

class ThemePage extends StatelessWidget {
  ThemePage({Key? key}) : super(key: key);

  final settingController = Get.put(SettingsController());

  final List<String> _listNameColor = [
    "Azure",
    "Go Green",
    "Sapphire",
    "Medium Pupple",
    "French Pink"
  ];
  final List<Color> _listColor = [
    ColorPalletes.azure,
    ColorPalletes.goGreen,
    ColorPalletes.sapphire,
    ColorPalletes.mediumPurple,
    ColorPalletes.frenchPink
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Themes",
          style: AppTextStyle.bigTitle,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    switch (i) {
                      case 0:
                        settingController.setPrimaryColor(
                            _listColor[i], _listNameColor[i]);
                        settingController.setThemePrimaryColor(_listColor[i],
                            key: _listNameColor[i]);

                        break;
                      case 1:
                        settingController.setPrimaryColor(
                          _listColor[i],
                          _listNameColor[i],
                        );
                        settingController.setThemePrimaryColor(
                          _listColor[i],
                          key: _listNameColor[i],
                        );

                        break;
                      case 2:
                        settingController.setPrimaryColor(
                          _listColor[i],
                          _listNameColor[i],
                        );
                        settingController.setThemePrimaryColor(
                          _listColor[i],
                          key: _listNameColor[i],
                        );

                        break;
                      case 3:
                        settingController.setPrimaryColor(
                          _listColor[i],
                          _listNameColor[i],
                        );
                        settingController.setThemePrimaryColor(
                          _listColor[i],
                          key: _listNameColor[i],
                        );

                        break;
                      case 4:
                        settingController.setPrimaryColor(
                          _listColor[i],
                          _listNameColor[i],
                        );
                        settingController.setThemePrimaryColor(
                          _listColor[i],
                          key: _listNameColor[i],
                        );

                        break;
                      default:
                    }
                  },
                  child: AppCard(
                    child: Row(
                      children: [
                        Obx(
                          () => Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.only(right: 16),
                            decoration: BoxDecoration(
                              color: _listColor[i],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: (settingController.primaryColor.value ==
                                    _listColor[i])
                                ? const Icon(
                                    UniconsLine.check,
                                    color: Colors.white,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                        Text(
                          _listNameColor[i],
                          style: AppTextStyle.normal,
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, i) {
                return const SizedBox(height: 10);
              },
              itemCount: _listColor.length,
            ),
          )
        ],
      ),
    );
  }
}
