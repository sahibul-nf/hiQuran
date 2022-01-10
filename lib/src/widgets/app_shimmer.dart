import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;

  const AppShimmer({
    Key? key,
    required this.height,
    this.width,
    this.radius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.grey[200]!,
      baseColor: Colors.white,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [AppShadow.card],
        ),
      ),
    );
  }
}
