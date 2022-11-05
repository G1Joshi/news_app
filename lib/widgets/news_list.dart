import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:news_app/models/article_model.dart';
import 'package:news_app/screens/news/news.dart';
import 'package:news_app/utils/strings.dart';
import 'package:news_app/utils/styles.dart';
import 'package:news_app/widgets/widgets.dart';

class NewsList extends StatelessWidget {
  const NewsList(this.data, {Key? key}) : super(key: key);

  final List<Article> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (index % 5 == 0) {
          return NewsBigCard(data[index]);
        } else {
          return NewsSmallCard(data[index]);
        }
      },
    );
  }
}

class NewsSmallCard extends StatelessWidget {
  const NewsSmallCard(this.data, {Key? key}) : super(key: key);

  final Article data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(
          PageRouteBuilder(
            fullscreenDialog: true,
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondary) => NewsDetails(data),
            transitionsBuilder: (context, animation, secondary, child) =>
                FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: data.url,
                    child: CachedNetworkImage(
                      imageUrl: data.urlToImage,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      placeholder: (context, url) => const Loader(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.source.name,
                        style: Styles.bold18,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        data.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.primary15,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${DateTime.now().difference(DateTime.parse(data.publishedAt)).inHours} ${Strings.hoursAgo}',
                        maxLines: 3,
                        style: Styles.grey12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsBigCard extends StatelessWidget {
  const NewsBigCard(this.data, {Key? key}) : super(key: key);

  final Article data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.of(context).push(
          PageRouteBuilder(
            fullscreenDialog: true,
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondary) => NewsDetails(data),
            transitionsBuilder: (context, animation, secondary, child) =>
                FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Hero(
                  tag: data.url,
                  child: CachedNetworkImage(
                    imageUrl: data.urlToImage,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                    placeholder: (context, url) => const Loader(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image,
                      size: 100,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.source.name,
                      style: Styles.bold18,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      data.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.primary15,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${DateTime.now().difference(DateTime.parse(data.publishedAt)).inHours} ${Strings.hoursAgo}',
                      maxLines: 3,
                      style: Styles.grey12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
