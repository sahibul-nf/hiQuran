class Article {
  String? title;
  String? link;
  String? logo;
  String? website;
  String? author;
  String? thumbnail;
  String? datePublished;
  List<String>? categories;

  Article({
    required this.logo,
    required this.website,
    this.title,
    this.link,
    this.author,
    this.thumbnail,
    this.datePublished,
    this.categories,
  });
}
