import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/my_outline_button.dart';

import '../../bricks/my_widgets/my_button.dart';
import '../settings/theme/app_theme.dart';

class AppPermissionStatus extends StatelessWidget {
  final String message;
  final IconData icon;
  final String title;
  final Function() onPressed;
  const AppPermissionStatus(
      {Key? key,
      required this.message,
      required this.icon,
      required this.title, required this.onPressed})
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
              icon,
              size: 90,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
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
            text: "Allow",
            width: MediaQuery.of(context).size.width,
            onPressed: onPressed,
          ),
          const SizedBox(height: 10),
          MyOutlinedButton(
            text: "Don't Allow",
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              Get.back();
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
