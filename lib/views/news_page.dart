import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';
import 'package:news_app/views/article_page.dart';

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
            return ListView.separated(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => ListTile(
                onTap: () => Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticlePage(data: data[index]),
                    ),
                  );
                }),
                leading: Image.network(
                  data[index].urlToImage,
                  height: 24,
                  width: 24,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) =>
                      loadingProgress == null
                          ? child
                          : CircularProgressIndicator(),
                  errorBuilder: (context, exception, stackTrace) =>
                      Icon(Icons.image),
                ),
                title: Text(data[index].title),
                subtitle: Text(data[index].author),
                trailing: Text(data[index].source.name),
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
