import 'package:flutter/material.dart';

class Icon3DFb13 extends StatelessWidget {
  const Icon3DFb13({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/illustration/notebook-dynamic-color.png",
      fit: BoxFit.cover,
      cacheHeight: 200,
      cacheWidth: 200,
    );
  }
}
