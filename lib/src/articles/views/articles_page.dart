import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/helper/constans.dart';
import 'package:quran_app/src/articles/controllers/article_controller.dart';
import 'package:quran_app/src/articles/widgets/article_card.dart';
import 'package:quran_app/src/articles/widgets/article_card_shimmer.dart';
import 'package:quran_app/src/settings/theme/app_theme.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final articleC = Get.put(ArticleController());
    articleC.loadArticle();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Articles",
            style: AppTextStyle.bigTitle,
          ),
          centerTitle: true,
          elevation: 1,
          // actions: [
          //   IconButton(
          //     onPressed: () => Get.toNamed(SearchQuranPage.routeName),
          //     icon: const Icon(
          //       UniconsLine.search,
          //     ),
          //   ),
          //   const SizedBox(width: 8),
          // ],
        ),
        body: Obx(
          () {
            return articleC.articleIsLoading.value
                ? ListView.separated(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(
                      // horizontal: 20,
                      vertical: 20,
                    ),
                    itemBuilder: (context, i) {
                      return const ArticleCardShimmer();
                    },
                    separatorBuilder: (context, i) {
                      return const SizedBox(height: 20);
                    },
                    itemCount: 3,
                  )
                : ListView.separated(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    itemBuilder: (context, i) {
                      return FadeInDown(
                        from: 50,
                        child: ArticleCard(
                          height: 450,
                          logoUrl: articleC.articles.toList()[i].logo!,
                          title: articleC.articles.toList()[i].title!,
                          pubDate: articleC.articles.toList()[i].datePublished!,
                          thumbnailUrl:
                              articleC.articles.toList()[i].thumbnail!,
                          author: articleC.articles.toList()[i].author!,
                          onTap: () => Helper.launchURL(
                            articleC.articles.toList()[i].link!,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return const SizedBox(height: 20);
                    },
                    itemCount: articleC.articles.length,
                  );
          },
        ));
  }
}
