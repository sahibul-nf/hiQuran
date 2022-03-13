import 'package:flutter/material.dart';

class MyCircleAvatar extends StatelessWidget {
  /// the base color of the images background and its concentric circles.
  final Color primaryColor;

  /// the profile image to be displayed.
  final ImageProvider image;

  ///the diameter of the entire widget, including the concentric circles.
  final double size;

  /// the width between the edges of each concentric circle.
  final double transitionBorderwidth;

  const MyCircleAvatar(
      {Key? key,
      required this.primaryColor,
      required this.image,
      this.size = 190.0,
      this.transitionBorderwidth = 20.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: primaryColor.withOpacity(0.05)),
        ),
        Container(
            height: size - transitionBorderwidth,
            width: size - transitionBorderwidth,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                  stops: const [0.01, 0.5],
                  colors: [Colors.white, primaryColor.withOpacity(0.1)]),
            )),
        Container(
            height: size - (transitionBorderwidth * 2),
            width: size - (transitionBorderwidth * 2),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: primaryColor.withOpacity(0.4))),
        Container(
            height: size - (transitionBorderwidth * 3),
            width: size - (transitionBorderwidth * 3),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: primaryColor.withOpacity(0.5))),
        Container(
            height: size - (transitionBorderwidth * 4),
            width: size - (transitionBorderwidth * 4),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(fit: BoxFit.cover, image: image)))
      ],
    );
  }
}
