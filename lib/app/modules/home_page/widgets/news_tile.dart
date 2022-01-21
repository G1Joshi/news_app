import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../../../data/models/article_model.dart';
import '../../../data/values/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/styles.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({Key? key, required this.data}) : super(key: key);

  final Article data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Get.toNamed(Routes.NEWS_PAGE, arguments: data);
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.source.name,
                        style: Styles.tsBoldItalic17,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        data.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.tsPrimaryDark16,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${DateTime.now().difference(DateTime.parse(data.publishedAt)).inHours} ${Strings.hoursAgo}',
                        maxLines: 3,
                        style: Styles.tsGrey12,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Hero(
                    tag: data.url,
                    child: CachedNetworkImage(
                      imageUrl: data.urlToImage,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.image,
                        size: 100,
                      ),
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
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
