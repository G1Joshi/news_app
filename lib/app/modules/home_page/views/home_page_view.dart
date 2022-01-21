import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../data/models/category_model.dart';
import '../../../data/models/country_model.dart';
import '../../../data/models/source_model.dart';
import '../../../data/values/enums.dart';
import '../../../data/values/strings.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/styles.dart';
import '../controllers/home_page_controller.dart';
import '../widgets/news_tile.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
          style: Styles.tsBold20,
        ),
        centerTitle: false,
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
                        Strings.chooseLocation,
                        style: Styles.tsBold20,
                      ),
                      const Divider(),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: Country.countries.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            controller.setCountry(index);
                            controller.resetFilter();
                            Get.back();
                            controller.getTopNews();
                            controller.getSources();
                          },
                          title: Text(
                            Country.countries[index].name,
                            style: Styles.tsPrimaryDarkBold20,
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
                  Strings.location,
                  style: Styles.tsSecondaryLight14,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppColors.secondaryColorLight,
                    ),
                    Obx(() => Text(
                          controller.countryName.value,
                          style: Styles.tsSecondaryLightBold15,
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
          controller: controller.scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: HomePageController.queryController,
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    controller.searching(true);
                  } else {
                    controller.searching(false);
                  }
                  controller.resetFilter();
                  controller.getQueryNews();
                },
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  filled: true,
                  isCollapsed: true,
                  fillColor: AppColors.secondaryColorDark.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  suffixIcon: Obx(() => controller.searching.isTrue
                      ? IconButton(
                          onPressed: () {
                            controller.searching(false);
                            HomePageController.queryController.clear();
                            controller.getQueryNews();
                          },
                          icon: const Icon(Icons.close))
                      : const Icon(Icons.search)),
                  hintText: Strings.searchForNews,
                  hintStyle: const TextStyle(height: 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                if (controller.newsStatus.value == NewsStatus.loaded) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              Strings.topHeadlines,
                              style: Styles.tsBold18,
                            ),
                          ),
                          const Text(
                            Strings.sort,
                            style: Styles.ts14,
                          ),
                          DropdownButton(
                            isDense: true,
                            iconSize: 20,
                            hint: const Text(Strings.category),
                            value: HomePageController.category,
                            underline: const SizedBox.shrink(),
                            style: Styles.tsPrimaryDarkBold14,
                            items: Category.categories
                                .map(
                                  (value) => DropdownMenuItem(
                                    value: value.code,
                                    child: Text(value.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (newValue) async {
                              controller.resetFilter();
                              HomePageController.category = newValue.toString();
                              controller.getCategoryNews();
                            },
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: controller.news.articles.length,
                        itemBuilder: (context, index) => NewsTile(
                          data: controller.news.articles[index],
                        ),
                      ),
                      if (controller.pagination.isTrue)
                        const CircularProgressIndicator(),
                    ],
                  );
                } else if (controller.newsStatus.value == NewsStatus.empty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.file_copy,
                        size: 50,
                        color: Colors.grey[800],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        Strings.noResultFound,
                        style: Styles.tsBlackBold20,
                      ),
                    ],
                  );
                } else if (controller.newsStatus.value == NewsStatus.error) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.signal_wifi_connected_no_internet_4,
                        size: 50,
                        color: Colors.grey[800],
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        Strings.somethingWentWrong,
                        style: Styles.tsBlackBold20,
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () => controller.getTopNews(),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryColorLight),
                        ),
                        child: const Text(
                          Strings.tryAgain,
                          style: Styles.ts16,
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
        if (controller.sourcesStatus.value == SourcesStatus.loaded) {
          return FloatingActionButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (_context) {
                  if (controller.sources.sources.isEmpty) {
                    return SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.file_copy,
                            size: 50,
                            color: Colors.grey[800],
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            Strings.noSources,
                            style: Styles.tsBlackBold20,
                          ),
                        ],
                      ),
                    );
                  }
                  return MultiSelectBottomSheet<Source>(
                    title: const Text(
                      Strings.filterSources,
                      style: Styles.tsBold20,
                    ),
                    items: controller.sources.sources
                        .map((e) => MultiSelectItem(e, e.name))
                        .toList(),
                    initialValue: controller.selectedSources,
                    onConfirm: (values) {
                      HomePageController.source = Strings.empty;
                      controller.selectedSources = values;
                      for (var element in values) {
                        HomePageController.source += '${element.id},';
                      }
                      HomePageController.page = 1;
                      HomePageController.category = null;
                      controller.selectedSources.isEmpty
                          ? controller.getTopNews()
                          : controller.getSourceNews();
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
