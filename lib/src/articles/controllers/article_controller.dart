import 'dart:developer';

import 'package:get/get.dart';
import 'package:quran_app/src/articles/repositories/article_repository.dart';

import '../entities/article.dart';

class ArticleController extends GetxController
    with GetTickerProviderStateMixin {
  var articles = <Article>{}.obs;
  var articlesAtHome = <Article>{}.obs;
  var articleAtHomeIsLoading = false.obs;
  var articleIsLoading = false.obs;

  Future<void> loadArticleforHome() async {
    articleAtHomeIsLoading.value = true;

    final feedsResource = await ArticleRepository.getRSSFeed(limit: 1);

    if (feedsResource != null) {
      for (var element in feedsResource) {
        final feed = await ArticleRepository.convertRSS(element.url);
        if (feed != null) {
          for (var item in feed.items) {
            Article _article =
                Article(logo: feed.feed.image, website: feed.feed.link);
            _article.title = item.title;
            _article.link = item.link;
            _article.thumbnail = item.thumbnail;
            _article.datePublished = item.pubDate;
            _article.categories = item.categories;
            _article.author = item.author;

            if (articlesAtHome.length <= 3) {
              articlesAtHome.add(_article);
            } else {
              break;
            }
          }
        }
      }
    }

    articleAtHomeIsLoading.value = false;
  }

  Future<void> loadArticle() async {
    articleIsLoading.value = true;

    final feedsResource = await ArticleRepository.getRSSFeed();

    if (feedsResource == null) {
      articleIsLoading.value = false;
      return;
    }

    for (var element in feedsResource) {
      final feed = await ArticleRepository.convertRSS(element.url);
      if (feed != null) {
        for (var item in feed.items) {
          Article _article =
              Article(logo: feed.feed.image, website: feed.feed.link);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          articles.add(_article);

          articleIsLoading.value = false;
        }
      }

      log(articles.length.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadArticleforHome();
  }
}
