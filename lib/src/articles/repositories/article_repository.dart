import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/rss_feed.dart';

const rss2JsonApiKey = "nsefnfsafaqpiwde3lggd8fitlzlyve0ozfhusja";

class ArticleRepository {
  static Future<RssFeed?> fetchFeed(String feedUrl) async {
    // api for convert rss2Json
    final url =
        "https://api.rss2json.com/v1/api.json?rss_url=$feedUrl&api_key=$rss2JsonApiKey";

    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(url));

      final body = jsonDecode(response.body);

      RssFeed rssFeed = RssFeed.fromJson(body);

      return rssFeed;
    } catch (e) {
      log("Error: " + e.toString());
      return null;
    }
  }
}
