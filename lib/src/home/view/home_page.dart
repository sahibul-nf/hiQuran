import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:quran_app/bricks/my_widgets/my_button.dart';
import 'package:quran_app/src/home/controller/home_controller.dart';
import 'package:quran_app/src/profile/controllers/user_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_drawer.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final authController = Get.put(UserControllerImpl());
  final homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // var theme = Theme.of(context);
    return Scaffold(
      key: _key,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "hiQuran",
          style: AppTextStyle.bigTitle,
        ),
        leading: IconButton(
          onPressed: () => _key.currentState!.openDrawer(),
          icon: const Icon(
            UniconsSolid.apps,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SizedBox(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => homeC.currentLocation.value.isEmpty
                  ? const Text(
                      "No data",
                    )
                  : Text(
                      homeC.currentLocation.value,
                    ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 30),
              child: Text("Select your location"),
            ),
            MyButton(
              text: "Current Location",
              onPressed: () {
                homeC.getLocation();
              },
            )
          ],
        ),
      ),
      // body: Container(
      //   width: size.width,
      //   height: size.height * 0.4,
      //   padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(20),
      //     child: ModelViewer(
      //       src:
      //           "https://d1a370nemizbjq.cloudfront.net/aa4ebe65-6aab-4d9b-864f-d9f905996966.glb",
      //       // src: userController.copiedText.value,
      //       autoRotate: true,
      //       cameraControls: true,
      //       // backgroundColor: theme.primaryColor,
      //       alt: "A 3D model of user avatar",
      //       // ar: true,
      //     ),
      //   ),
      // )
    );
  }
}
