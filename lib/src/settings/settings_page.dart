import 'package:flutter/material.dart';
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
      body: Container(),
    );
  }
}
