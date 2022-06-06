import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/settings/theme/theme_page.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:unicons/unicons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: AppTextStyle.bigTitle,
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          InkWell(
            onTap: () => Get.to(ThemePage()),
            child: AppCard(
              child: Row(
                children: [
                  Container(
                    // height: 30,
                    // width: 30,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Icon(
                      UniconsLine.palette,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "Change App Theme",
                    style: AppTextStyle.normal,
                  ),
                  const Spacer(),
                  Icon(
                    UniconsLine.arrow_right,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
