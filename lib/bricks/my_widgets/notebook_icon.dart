import 'package:flutter/material.dart';

class Icon3DFb13 extends StatelessWidget {
  const Icon3DFb13({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/3d%20icons%2Fnotebook-dynamic-color.png?alt=media&token=c644a0d1-4f53-42a8-a34a-b7853c256903",
      fit: BoxFit.cover,
    );
  }
}