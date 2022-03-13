import 'package:flutter/material.dart';
import 'package:quran_app/bricks/my_widgets/dotted_loading_indicator.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class MyOutlinedButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;
  final bool isLoading;
  const MyOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 54,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          alignment: Alignment.center,
          side: BorderSide(width: 1, color: primaryColor),
          padding: const EdgeInsets.only(
              right: 75, left: 75, top: 12.5, bottom: 12.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          primary: primaryColor,
        ),
        onPressed: onPressed,
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DottedCircularProgressIndicatorFb(
                    currentDotColor: Theme.of(context).primaryColor,
                    defaultDotColor: Colors.grey,
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
            : Text(text, style: AppTextStyle.title),
      ),
    );
  }
}
