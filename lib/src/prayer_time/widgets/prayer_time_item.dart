import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:unicons/unicons.dart';

class PrayerTimeItem extends StatelessWidget {
  final int hour;
  final int minute;
  final String prayerTime;
  const PrayerTimeItem(
      {Key? key,
      required this.hour,
      required this.minute,
      required this.prayerTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$hour:$minute",
          style: AppTextStyle.normal.copyWith(
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 16),
        Chip(
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          label: Text(
            prayerTime,
            style: AppTextStyle.small.copyWith(
              color: Theme.of(context).primaryColor,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            UniconsLine.volume,
          ),
        )
      ],
    );
  }
}
