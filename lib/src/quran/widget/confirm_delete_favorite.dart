import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class ConfirmDeleteFavorite extends StatelessWidget {
  const ConfirmDeleteFavorite(
      {Key? key,
      required this.onDelete,
      required this.onCancel,
      required this.message})
      : super(key: key);
  final Function() onDelete;
  final Function() onCancel;
  final String message;

  @override
  Widget build(BuildContext context) {
    final surahC = Get.find<SurahController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [AppShadow.card],
          ),
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/illustration/empty-state-list-1.svg",
                width: 180,
              ),
              const SizedBox(height: 30),
              Text(
                message,
                style: AppTextStyle.title.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              MyButton(
                text: "Cancel",
                onPressed: onCancel,
                color: Colors.grey.shade100,
                onPrimaryColor: ColorPalletes.bgDarkColor,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 16),
              Obx(
                () => MyButton(
                  text: "Delete",
                  onPressed: onDelete,
                  color: Colors.red,
                  onPrimaryColor: Colors.white,
                  isLoading: surahC.isFavoriteDeleted.value,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
