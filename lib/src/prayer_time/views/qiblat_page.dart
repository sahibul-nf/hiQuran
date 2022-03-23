import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_drawer.dart';
import 'package:unicons/unicons.dart';

class QiblatPage extends StatelessWidget {
  QiblatPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "Qiblat",
          style: AppTextStyle.bigTitle,
        ),
        leading: IconButton(
          onPressed: () => _key.currentState!.openDrawer(),
          icon: const Icon(
            UniconsLine.icons,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "assets/illustration/3D-Kaaba.png",
                width: 70,
              ),
            )
          ],
        ),
      ),
    );
  }
}
