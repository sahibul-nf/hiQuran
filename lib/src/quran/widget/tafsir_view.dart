import 'package:flutter/material.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class TafsirView extends StatelessWidget {
  const TafsirView(
      {Key? key, this.textTafsir, this.numberInSurah, required this.closeShow})
      : super(key: key);
  final String? textTafsir;
  final int? numberInSurah;
  final void Function() closeShow;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.9,
      minChildSize: 0.25,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: closeShow,
                icon: const Icon(
                  Icons.highlight_remove_rounded,
                  size: 30,
                  color: Colors.red,
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Text(
                        "Tafsir Ayat ke - $numberInSurah",
                        style: AppTextStyle.title,
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "$textTafsir",
                          style: AppTextStyle.normal.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
