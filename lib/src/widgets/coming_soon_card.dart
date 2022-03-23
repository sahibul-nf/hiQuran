import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class ComingSoonCard extends StatelessWidget {
  const ComingSoonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
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
          Image.asset(
            "assets/illustration/01. Parents Teach Children to Read The Quran.png",
            width: 210,
          ),
          Text(
            "Opps, Coming soon!",
            style: AppTextStyle.title.copyWith(
              fontSize: 18,
              // color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "This feature will be coming soon, \ngive hiQuran your feedback for \nimprove this app",
            style: AppTextStyle.small.copyWith(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          const SizedBox(height: 20),
          MyButton(
            text: "Give Feedback",
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              Get.back();
              url.launch("https://s.id/hiQuran").then((value) {
                if (!value) {
                  Get.snackbar("Opps...", "An error occured");
                }
              });
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
