import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';
import 'package:news_app/views/news_tile.dart';

class NewsPage extends StatefulWidget {
  NewsPage({required this.country});
  final String country;

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsPage> {
  late NewsAPI api;
  late Future<News> news;

  @override
  void initState() {
    api = NewsAPI();
    news = api.getData(widget.country);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News 24x7',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<News>(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Article> data = snapshot.data!.articles;
            return ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) => NewsTile(
                data: data[index],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
