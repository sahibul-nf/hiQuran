class RSSFeedResource {
  final String id;
  final String title;
  final String url;
  final String country;

  RSSFeedResource({
    required this.id,
    required this.title,
    required this.url,
    required this.country,
  });

  factory RSSFeedResource.fromJson(Map<String, dynamic> json) {
    return RSSFeedResource(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      country: json['country'],
    );
  }
}
