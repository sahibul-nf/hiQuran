import 'dart:developer';

import 'package:get/get.dart';
import 'package:quran_app/src/articles/repositories/article_repository.dart';

import '../entities/Article.dart';

const rssFeeds = <String, String>{
  "mutiaraIslam": "https://mutiaraislam.net/feed/",
  "aboutIslamSpirituality": "https://aboutislam.net/spirituality/feed/",
};

class ArticleController extends GetxController {
  var articles = <Article>{}.obs;
  var articlesAtHome = <Article>{}.obs;
  var articleAtHomeIsLoading = false.obs;
  var articleIsLoading = false.obs;

  Future<void> loadArticleforHome() async {
    articleAtHomeIsLoading.value = true;

    final feed = await ArticleRepository.fetchFeed(rssFeeds.values.first);
    if (feed != null) {
      for (var item in feed.items) {
        Article _article = Article(logo: feed.feed.image);
        _article.title = item.title;
        _article.link = item.link;
        _article.thumbnail = item.thumbnail;
        _article.datePublished = item.pubDate;
        _article.categories = item.categories;
        _article.author = item.author;

        if (articlesAtHome.length <= 3) {
          articlesAtHome.add(_article);
          log(articlesAtHome.length.toString());
        }

        articleAtHomeIsLoading.value = false;
        await Future.delayed(800.milliseconds);
      }
    }
  }

  Future<void> loadArticle() async {
    articleIsLoading.value = true;

    rssFeeds.forEach((key, value) async {
      final feed = await ArticleRepository.fetchFeed(value);
      if (feed != null) {
        for (var item in feed.items) {
          Article _article = Article(logo: feed.feed.image);
          _article.title = item.title;
          _article.link = item.link;
          _article.thumbnail = item.thumbnail;
          _article.datePublished = item.pubDate;
          _article.categories = item.categories;
          _article.author = item.author;

          articles.add(_article);

          articleIsLoading.value = false;
          await Future.delayed(800.milliseconds);
        }
      }

      log(articles.length.toString());
    });

    articleIsLoading.value = false;
  }

  @override
  void onInit() {
    loadArticleforHome();
    super.onInit();
  }
}
