import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../bricks/my_widgets/my_button.dart';
import '../settings/theme/app_theme.dart';

class AppPermissionStatus extends StatelessWidget {
  final String message;
  const AppPermissionStatus({Key? key, required this.message}) : super(key: key);

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
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              UniconsLine.lock_access,
              size: 90,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: AppTextStyle.normal.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          // const SizedBox(height: 16),
          MyButton(
            text: "Allow Permission",
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              Get.back();
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
