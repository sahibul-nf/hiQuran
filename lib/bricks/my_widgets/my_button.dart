import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/dotted_loading_indicator.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final double? width;
  final double? height;
  final bool isLoading;
  MyButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    Key? key,
    this.width,
    this.height = 54,
  }) : super(key: key);

  final settingController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    const double borderRadius = 15;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 15),
          primary: primaryColor,
          onPrimary: Theme.of(context).backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedCircularProgressIndicatorFb(
                    currentDotColor:
                        Theme.of(context).cardColor.withOpacity(0.3),
                    defaultDotColor: Theme.of(context).cardColor,
                    numDots: 7,
                    dotSize: 3,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Loading...",
                    style: AppTextStyle.normal.copyWith(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: AppTextStyle.title,
              ),
      ),
    );
  }
}
