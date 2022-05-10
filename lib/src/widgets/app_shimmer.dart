import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double? height;
  final double? width;
  final double radius;
  final Color? color;

  const AppShimmer({
    Key? key,
    required this.height,
    this.width,
    this.radius = 20,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: color?.withOpacity(0.2) ??
          Theme.of(context).cardColor.withOpacity(0.1),
      baseColor: color ?? Theme.of(context).cardColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [AppShadow.card],
        ),
      ),
    );
  }
}
