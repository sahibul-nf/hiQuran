import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/dotted_loading_indicator.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class GoogleBtn1 extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool isLoading;

  GoogleBtn1({
    required this.onPressed,
    Key? key,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);

  final _settingController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          elevation: 0,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedCircularProgressIndicatorFb(
                    currentDotColor: _settingController.isDarkMode.value
                        ? Theme.of(context).backgroundColor.withOpacity(0.3)
                        : Theme.of(context).primaryColor.withOpacity(0.3),
                    defaultDotColor: _settingController.isDarkMode.value
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).primaryColor,
                    numDots: 7,
                    dotSize: 3,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Loading...",
                    style: AppTextStyle.normal.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeIn(
                    child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
                      width: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$text with Google",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
        onPressed: onPressed,
      ),
    );
  }
}
