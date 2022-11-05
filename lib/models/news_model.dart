import 'package:news_app/models/article_model.dart';

class News {
  News({
    required this.status,
    required this.message,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final String message;
  final int totalResults;
  final List<Article> articles;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      totalResults: json["totalResults"] ?? 0,
      articles: List<Article>.from(
        json["articles"].map((x) => Article.fromJson(x)),
      ),
    );
  }
}
