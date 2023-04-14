import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/src/articles/models/rss_feed_resource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/rss_feed.dart';

String rss2JsonApiKey = dotenv.get("RSS2JSON_API_KEY");

class ArticleRepository {
  static Future<RssFeed?> convertRSS(String feedUrl) async {
    // api for convert rss2Json
    final url =
        "https://api.rss2json.com/v1/api.json?rss_url=$feedUrl&api_key=$rss2JsonApiKey&count=1000";

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

  static Future<List<RSSFeedResource>?> getRSSFeed({int? limit}) async {
    final supabase = Supabase.instance.client;

    final query = limit == null
        ? await supabase
            .from("RSSFeeds")
            .select()
            .order("title", ascending: false)
            .execute()
        : await supabase
            .from("RSSFeeds")
            .select()
            .limit(limit)
            .order("title", ascending: false)
            .execute();

    if (query.error != null) {
      log("Error: " + query.error!.message);
      return null;
    }

    // log("Data: " + query.data.toString());

    List<RSSFeedResource> rssFeeds = [];

    for (var item in query.data!) {
      RSSFeedResource _rssFeed = RSSFeedResource.fromJson(item);

      rssFeeds.add(_rssFeed);
    }

    return rssFeeds;
  }
}
