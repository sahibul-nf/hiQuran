import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Get.changeTheme(AppTheme.dark),
              child: const Text("Dark"),
            ),
            ElevatedButton(
              onPressed: () => Get.changeTheme(AppTheme.light),
              child: const Text("Light"),
            ),
          ],
        ),
      ),
    );
  }
}
