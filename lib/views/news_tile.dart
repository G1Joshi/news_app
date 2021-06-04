import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    required this.data,
  });

  final Article data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.source.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    data.author,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            Image.network(
              data.urlToImage,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : CircularProgressIndicator(),
              errorBuilder: (context, exception, stackTrace) =>
                  Icon(Icons.image),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                data.title,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
