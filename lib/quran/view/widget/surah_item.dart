import 'package:flutter/material.dart';

class SurahItem extends StatelessWidget {
  const SurahItem(
      {Key? key,
      this.number,
      this.nameTransliteration,
      this.revelation,
      this.nameShort, this.numberOfVerses})
      : super(key: key);
  final int? number;
  final String? nameTransliteration;
  final String? revelation;
  final String? nameShort;
  final int? numberOfVerses;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      // height: 70,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("$number"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$nameTransliteration"),
                  Row(
                    children: [
                      Text("$revelation"),
                      Text(" - $numberOfVerses Verses"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Text("$nameShort"),
        ],
      ),
    );
  }
}
