import 'package:flutter/material.dart';
import 'package:quran_app/bricks/my_widgets/dotted_loading_indicator.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppCard(
        hMargin: MediaQuery.of(context).size.width / 4,
        vPadding: 30,
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: DottedCircularProgressIndicatorFb(
                defaultDotColor:
                    Theme.of(context).primaryColor.withOpacity(0.7),
                currentDotColor:
                    Theme.of(context).primaryColor.withOpacity(0.3),
                numDots: 9,
                dotSize: 5,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Wait a moment...",
              style: AppTextStyle.small,
            )
          ],
        ),
      ),
    );
  }
}
