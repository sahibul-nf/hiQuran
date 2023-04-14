import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({
    Key? key,
    required this.logoUrl,
    required this.title,
    required this.pubDate,
    required this.thumbnailUrl,
    required this.author,
    required this.onTap,
    this.height,
    required this.website,
  }) : super(key: key);

  final String logoUrl;
  final String website;
  final String title;
  final String pubDate;
  final String thumbnailUrl;
  final String author;
  final void Function() onTap;
  final double? height;

  bool isNewStorie(DateTime pubDate) {
    var timeNow = DateTime.now();

    bool isSameMonth = timeNow.month == pubDate.month;
    bool isSameYear = timeNow.year == pubDate.year;

    return isSameYear && isSameMonth;
  }

  @override
  Widget build(BuildContext context) {
    bool isNew = isNewStorie(DateTime.parse(pubDate));

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        height: height,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          // vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [AppShadow.card],
          border: Get.isDarkMode
              ? null
              : Border.all(
                  color: Colors.grey.shade100,
                ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: logoUrl == ""
                      ? Image.asset(
                          "assets/icon/icon.png",
                          width: 30,
                        )
                      : CachedNetworkImage(
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/icon/icon.png"),
                          placeholder: (context, url) =>
                              Image.asset("assets/icon/icon.png"),
                          imageUrl: logoUrl,
                          width: 36,
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    author,
                    style: AppTextStyle.normal,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                (isNew) ? const Spacer() : const SizedBox(),
                (isNew)
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          boxShadow: [AppShadow.card],
                        ),
                        child: Text(
                          "New",
                          style: AppTextStyle.normal.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: AppTextStyle.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Center(
                    child: SpinKitFadingCircle(
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ),
                  imageUrl: thumbnailUrl,
                  // height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [AppShadow.card],
                        border: Get.isDarkMode
                            ? null
                            : Border.all(
                                color: Colors.grey.shade100,
                              ),
                      ),
                      child: Center(
                        child: Text(
                          "hiQuran",
                          style: AppTextStyle.title.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     // color: Theme.of(context).primaryColor.withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(15),
            //     boxShadow: [AppShadow.card],
            //     border: Border.all(
            //       color: Colors.grey.shade100,
            //     ),
            //   ),
            //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //   child: InkWell(
            //     onTap: onTap,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Read post",
            //           style: AppTextStyle.normal.copyWith(
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //         const SizedBox(width: 8),
            //         Icon(
            //           Icons.open_in_new_rounded,
            //           size: 16,
            //           color: Theme.of(context).primaryColor,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
