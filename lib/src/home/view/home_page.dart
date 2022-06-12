import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:images_picker/images_picker.dart';
import 'package:quran_app/bricks/my_widgets/dotted_loading_indicator.dart';
import 'package:quran_app/bricks/my_widgets/notebook_icon.dart';
import 'package:quran_app/helper/constans.dart';
import 'package:quran_app/src/articles/controllers/article_controller.dart';
import 'package:quran_app/src/articles/views/articles_page.dart';
import 'package:quran_app/src/articles/widgets/article_card.dart';
import 'package:quran_app/src/articles/widgets/article_card_shimmer.dart';
import 'package:quran_app/src/home/controller/home_controller.dart';
import 'package:quran_app/src/prayer_time/controllers/prayer_time_controller.dart';
import 'package:quran_app/src/prayer_time/views/prayer_time_page.dart';
import 'package:quran_app/src/prayer_time/widgets/prayer_time_card.dart';
import 'package:quran_app/src/prayer_time/widgets/prayer_time_card_shimmer.dart';
import 'package:quran_app/src/profile/controllers/user_controller.dart';
import 'package:quran_app/src/profile/views/profile_page.dart';
import 'package:quran_app/src/quran/controller/surah_controller.dart';
import 'package:quran_app/src/quran/view/surah_detail_page.dart';
import 'package:quran_app/src/quran/view/surah_page.dart';
import 'package:quran_app/src/settings/controller/settings_controller.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';
import 'package:quran_app/src/widgets/app_card.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final userC = Get.put(UserControllerImpl());
  final homeC = Get.put(HomeController());
  final prayerTimeC = Get.put(PrayerTimeControllerImpl());
  final _settingsController = Get.put(SettingsController());
  final surahC = Get.put(SurahController());
  final articleC = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1500));
            prayerTimeC.getLocation().then((_) {
              prayerTimeC.cT.restart(duration: prayerTimeC.leftOver.value);
            });

            articleC.loadArticleforHome();
          },
          backgroundColor: Theme.of(context).cardColor,
          color: Theme.of(context).primaryColor,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => ProfilePage()),
                            child: Obx(
                              () => (userC.user.photoUrl != null)
                                  ? Hero(
                                      tag: "avatar",
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          userC.user.photoUrl.toString(),
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                              (ctx, child, loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }

                                            return Center(
                                              child: SizedBox(
                                                height: 36,
                                                child:
                                                    DottedCircularProgressIndicatorFb(
                                                  currentDotColor:
                                                      _settingsController
                                                              .isDarkMode.value
                                                          ? Theme.of(context)
                                                              .backgroundColor
                                                              .withOpacity(0.3)
                                                          : Theme.of(context)
                                                              .primaryColor
                                                              .withOpacity(0.3),
                                                  defaultDotColor:
                                                      _settingsController
                                                              .isDarkMode.value
                                                          ? Theme.of(context)
                                                              .backgroundColor
                                                          : Theme.of(context)
                                                              .primaryColor,
                                                  numDots: 7,
                                                  dotSize: 3,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Hero(
                                      tag: "avatarIcon",
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                          // color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        height: 50,
                                        width: 50,
                                        child: Icon(
                                          Icons.person,
                                          // size: 30,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Assalamu'alaikum,",
                                style: AppTextStyle.small.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              Obx(
                                () => Text(
                                  userC.user.name ?? "Hamba Allah",
                                  style: AppTextStyle.title,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: const Icon(
                      //     Icons.notifications_none,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () {
                          if (_settingsController.isDarkMode.value) {
                            final box = Get.find<GetStorage>();
                            var primaryColorName = box.read('primaryColor');

                            if (primaryColorName != null) {
                              _settingsController.setTheme(primaryColorName);
                            } else {
                              var listColor = _settingsController.listColor;
                              var listColorName =
                                  _settingsController.listColorName;
                              var primaryColor =
                                  _settingsController.primaryColor.value;

                              for (var i = 0; i <= 4; i++) {
                                if (listColor[i] == primaryColor) {
                                  _settingsController
                                      .setTheme(listColorName[i]);
                                }
                              }
                            }
                          } else {
                            _settingsController.setDarkMode(true);
                          }
                        },
                        icon: Icon(
                          _settingsController.isDarkMode.value
                              ? UniconsLine.moon
                              : UniconsLine.sun,
                          color:
                              Theme.of(context).iconTheme.color ?? Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                FadeInRight(
                  from: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(
                      () => prayerTimeC.isLoadLocation.value
                          ? const PrayerTimeCardShimmer()
                          : GestureDetector(
                              onTap: () => Get.to(
                                PrayerTimePage(),
                              ),
                              child: Hero(
                                tag: 'prayer_time_card',
                                child: PrayerTimeCard(prayerTimeC: prayerTimeC),
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInLeft(
                  from: 50,
                  child: AppCard(
                    vPadding: 16,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        UniconsLine.book_open,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Last Read",
                                        style: AppTextStyle.small.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Obx(
                                    () => Text(
                                      surahC.recenlySurah.name != null
                                          ? "Quran"
                                          : "Opps",
                                      style: AppTextStyle.bigTitle.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Obx(
                                    () => surahC.recenlySurah.name != null
                                        ? Text(
                                            "Surah " +
                                                surahC.recenlySurah.name!.id
                                                    .toString(),
                                            style: AppTextStyle.normal,
                                          )
                                        : Text(
                                            "You haven't read the quran lately.",
                                            style: AppTextStyle.small,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(child: Icon3DFb13(), width: 100),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            if (surahC.recenlySurah.name != null) {
                              Get.to(
                                SurahDetailPage(
                                  surah: surahC.recenlySurah,
                                ),
                              );
                            } else {
                              Get.to(SurahPage());
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [AppShadow.card],
                            ),
                            child: Center(
                              child: Obx(
                                () => Text(
                                  surahC.recenlySurah.name != null
                                      ? "Read again"
                                      : "Read Quran",
                                  style: AppTextStyle.normal.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Daily Articles",
                        style: AppTextStyle.bigTitle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        onTap: () => Get.to(() => const ArticlesPage()),
                        child: Text(
                          "See All",
                          style: AppTextStyle.small.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => articleC.articleAtHomeIsLoading.value
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: ArticleCardShimmer(),
                        )
                      : SizedBox(
                          height: 380,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            itemBuilder: (context, i) {
                              return Row(
                                children: [
                                  FadeInRight(
                                    from: 50,
                                    child: ArticleCard(
                                      logoUrl: articleC.articlesAtHome
                                          .toList()[i]
                                          .logo!,
                                      title: articleC.articlesAtHome
                                          .toList()[i]
                                          .title!,
                                      pubDate: articleC.articlesAtHome
                                          .toList()[i]
                                          .datePublished!,
                                      thumbnailUrl: articleC.articlesAtHome
                                          .toList()[i]
                                          .thumbnail!,
                                      author: articleC.articlesAtHome
                                          .toList()[i]
                                          .author!,
                                      onTap: () => Helper.launchURL(
                                        articleC.articlesAtHome
                                            .toList()[i]
                                            .link!,
                                      ),
                                    ),
                                  ),
                                  if (i == 3) const SizedBox(width: 20),
                                  if (i == 3)
                                    GestureDetector(
                                      onTap: () =>
                                          Get.to(() => const ArticlesPage()),
                                      child: AppCard(
                                        width: 130,
                                        hMargin: 0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "See All",
                                              style: AppTextStyle.normal,
                                            ),
                                            const SizedBox(height: 10),
                                            const Icon(UniconsLine.arrow_right),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                            separatorBuilder: (context, i) {
                              return const SizedBox(width: 20);
                            },
                            itemCount: articleC.articlesAtHome.length,
                          ),
                        ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
