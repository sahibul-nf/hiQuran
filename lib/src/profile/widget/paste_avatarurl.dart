import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/input_text.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/src/profile/controller/user_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:unicons/unicons.dart';

class PasteAvatarUrl extends StatelessWidget {
  PasteAvatarUrl({Key? key}) : super(key: key);
  final userController = Get.put(UserControllerImpl());
  final _textC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      hMargin: 0,
      hPadding: 30,
      vPadding: 30,
      color: Theme.of(context).backgroundColor,
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
              UniconsLine.clipboard_notes,
              size: 90,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Copy & Paste your created \navatar for save it",
            style: AppTextStyle.normal.copyWith(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Obx(
            () => userController.copiedText.value.isNotEmpty
                ? InputText(
                    textController: _textC,
                    hintText: userController.copiedText.value,
                    prefixIcon: const Icon(UniconsLine.edit_alt),
                    onChanged: (v) {
                      userController.copiedText.value = v;
                      _textC.text = v;
                    },
                  )
                : InputText(
                    textController: _textC,
                    hintText: "No copied data",
                    prefixIcon: const Icon(UniconsLine.edit_alt),
                    onChanged: (v) {
                      userController.copiedText.value = v;
                      _textC.text = v;
                    },
                  ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => userController.copiedText.isEmpty
                ? MyButton(
                    text: "Paste",
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      userController.getClipboardData();
                    },
                  )
                : MyButton(
                    text: "Done",
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      userController
                          .setAvatarUrl(userController.copiedText.value);
                      Get.back();
                    },
                  ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
