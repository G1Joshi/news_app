import 'package:news_app/models/article_model.dart';

class News {
  News({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      status: json["status"] ?? "",
      totalResults: json["totalResults"] ?? 0,
      articles: List<Article>.from(
        json["articles"].map((x) => Article.fromJson(x)),
      ),
    );
  }
}
