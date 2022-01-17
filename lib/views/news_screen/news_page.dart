import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:news_app/config/constants.dart';
import 'package:news_app/config/enums.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/controllers/news_controller.dart';
import 'package:news_app/controllers/sources_controller.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/country_model.dart';
import 'package:news_app/models/source_model.dart';
import 'package:news_app/views/news_screen/news_tile.dart';

class NewsPage extends StatelessWidget {
  NewsPage({Key? key}) : super(key: key);

  final newsController = Get.put(NewsController());
  final sourcesController = Get.put(SourcesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyNEWS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              await showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      const Text(
                        'Choose your location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: Country.countries.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () async {
                            await Preferences.setCountry(
                                Country.countries[index].name);
                            await Preferences.setCountryCode(
                                Country.countries[index].code);
                            newsController
                                .countryName(Country.countries[index].name);
                            NewsController.page = 1;
                            NewsController.category = null;
                            NewsController.sources = "";
                            newsController.selectedSources = [];
                            Get.back();
                            newsController.getTopNews();
                            sourcesController.getSources();
                          },
                          title: Text(
                            Country.countries[index].name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryColorDark,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryColorLight,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: secondaryColorLight,
                    ),
                    Obx(() => Text(
                          newsController.countryName.value,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: secondaryColorLight,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          controller: newsController.scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: NewsController.queryController,
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    newsController.searching(true);
                  } else {
                    newsController.searching(false);
                  }
                  NewsController.category = null;
                  NewsController.page = 1;
                  newsController.getQueryNews();
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  filled: true,
                  isCollapsed: true,
                  fillColor: secondaryColorDark.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  suffixIcon: Obx(() => newsController.searching.isTrue
                      ? IconButton(
                          onPressed: () {
                            newsController.searching(false);
                            NewsController.queryController.clear();
                            newsController.getQueryNews();
                          },
                          icon: const Icon(Icons.close))
                      : const Icon(Icons.search)),
                  hintText: 'Search for news, topics...',
                  hintStyle: const TextStyle(height: 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                if (newsController.newsStatus.value == NewsStatus.loaded) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Top Headlines',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            'Sort: ',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          DropdownButton(
                            isDense: true,
                            iconSize: 20,
                            hint: const Text('Category'),
                            value: NewsController.category,
                            underline: const SizedBox.shrink(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: primaryColorDark,
                              fontWeight: FontWeight.bold,
                            ),
                            items: Category.categories
                                .map(
                                  (value) => DropdownMenuItem(
                                    value: value.code,
                                    child: Text(value.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (newValue) async {
                              NewsController.category = newValue.toString();
                              NewsController.sources = "";
                              NewsController.page = 1;
                              newsController.selectedSources = [];
                              newsController.getCategoryNews();
                            },
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: newsController.news.articles.length,
                        itemBuilder: (context, index) => NewsTile(
                          data: newsController.news.articles[index],
                        ),
                      ),
                      if (newsController.pagination.isTrue)
                        const CircularProgressIndicator(),
                    ],
                  );
                } else if (newsController.newsStatus.value ==
                    NewsStatus.empty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_copy,
                        size: 50,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'No result found!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  );
                } else if (newsController.newsStatus.value ==
                    NewsStatus.error) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.signal_wifi_connected_no_internet_4,
                        size: 50,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Something went wrong!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          newsController.getTopNews();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColorLight),
                        ),
                        child: const Text(
                          'Try again',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (sourcesController.sourcesStatus.value == SourcesStatus.loaded) {
          return FloatingActionButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_context) {
                  if (sourcesController.sources.sources.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_copy,
                            size: 50,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'No Sources Available!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return MultiSelectBottomSheet<Source>(
                    title: const Text(
                      'Filter by sources',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    items: sourcesController.sources.sources
                        .map((e) => MultiSelectItem(e, e.name))
                        .toList(),
                    initialValue: newsController.selectedSources,
                    onConfirm: (values) {
                      NewsController.sources = "";
                      newsController.selectedSources = values;
                      for (var element in values) {
                        NewsController.sources += '${element.id},';
                      }
                      NewsController.page = 1;
                      NewsController.category = null;
                      newsController.selectedSources.isEmpty
                          ? newsController.getTopNews()
                          : newsController.getSourceNews();
                    },
                  );
                },
              );
            },
            child: const Icon(
              Icons.filter_alt_outlined,
              size: 30,
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
