import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({required this.data});
  final Article data;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
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
      body: Text(widget.data.content),
    );
  }
}
