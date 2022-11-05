import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import 'package:news_app/models/article_model.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/utils/strings.dart';
import 'package:news_app/utils/styles.dart';
import 'package:news_app/widgets/widgets.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails(this.data, {Key? key}) : super(key: key);

  final Article data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Stack(
              children: [
                Hero(
                  tag: data.url,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: data.urlToImage,
                      placeholder: (context, url) => const Loader(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image,
                        size: 300,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: kSecondaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          data.title,
                          style: Styles.secondaryBold16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.source.name,
                    style: Styles.bold20,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    DateFormat.yMMMMd()
                        .add_jm()
                        .format(DateTime.parse(data.publishedAt)),
                    style: Styles.primaryItalic12,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '${data.description}\n\n${data.content}',
                    style: Styles.primary16,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.story,
                        arguments: [data.source.name, data.url],
                      );
                    },
                    child: Row(
                      children: const [
                        Text(
                          Strings.seeFullStory,
                          style: Styles.primaryBold18,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: kPrimaryColor,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
