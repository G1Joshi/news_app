import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/values/strings.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/styles.dart';
import '../controllers/news_page_controller.dart';

class NewsPageView extends GetView<NewsPageController> {
  const NewsPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: Get.arguments.url,
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
                        imageUrl: Get.arguments.urlToImage,
                        placeholder: (context, url) => const Center(
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
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
                            color: AppColors.secondaryColorLight,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            Get.arguments.title,
                            style: Styles.tsSecondaryLightBold16,
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
                      Get.arguments.source.name,
                      style: Styles.tsBold20,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      DateFormat.yMMMMd()
                          .add_jm()
                          .format(DateTime.parse(Get.arguments.publishedAt)),
                      style: Styles.tsPrimaryDarkItalic12,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '${Get.arguments.description}\n\n${Get.arguments.content}',
                      style: Styles.tsPrimaryDark16,
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => Get.toNamed(
                        Routes.NEWS_DETAILS,
                        arguments: Get.arguments,
                      ),
                      child: Row(
                        children: const [
                          Text(
                            Strings.seeFullStory,
                            style: Styles.tsPrimaryLightBold18,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: AppColors.primaryColorLight,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
