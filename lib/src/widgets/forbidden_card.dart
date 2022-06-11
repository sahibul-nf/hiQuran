import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class ForbiddenCard extends StatelessWidget {
  const ForbiddenCard({Key? key, required this.onPressed}) : super(key: key);
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      child: Material(
        // color: Theme.of(context).cardColor,
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            FadeIn(
              child: SvgPicture.asset(
                "assets/illustration/cannot-access-state.svg",
                width: 190,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "Opps ...",
              style: AppTextStyle.bigTitle.copyWith(
                color: ColorPalletes.bgDarkColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Let's login first, then you can enjoy \nand explore this feature.",
              style: AppTextStyle.normal.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            MyButton(
              text: "Back",
              onPressed: () => Get.back(),
              // color: Colors.grey.shade100,
              color: Colors.grey.shade100,
              // onPrimaryColor: Theme.of(context).primaryColor,
              onPrimaryColor: ColorPalletes.bgDarkColor,
              width: MediaQuery.of(context).size.width * 0.75,
            ),
            const SizedBox(height: 16),
            MyButton(
              width: MediaQuery.of(context).size.width * 0.75,
              text: "Sign In",
              onPressed: onPressed,
              color: Get.isDarkMode
                  ? Theme.of(context).backgroundColor
                  : Theme.of(context).primaryColor,
              onPrimaryColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
