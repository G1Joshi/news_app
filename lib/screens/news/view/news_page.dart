import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:news_app/models/source_model.dart';
import 'package:news_app/screens/news/news.dart';
import 'package:news_app/utils/storage.dart';
import 'package:news_app/utils/strings.dart';
import 'package:news_app/utils/styles.dart';
import 'package:news_app/widgets/category_list.dart';
import 'package:news_app/widgets/country_list.dart';
import 'package:news_app/widgets/news_list.dart';
import 'package:news_app/widgets/widgets.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsBloc()..add(const GetTopNews()),
        ),
        BlocProvider(
          create: (context) => SourcesBloc()..add(const GetSources()),
        ),
      ],
      child: const NewsView(),
    );
  }
}

class NewsView extends StatelessWidget {
  const NewsView({Key? key}) : super(key: key);

  static List<Source> selectedSources = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: const SearchButton(),
        title: const Header(Strings.appName),
        actions: const [CountryList()],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          const CategoryList(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsLoaded) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            Strings.topHeadlines,
                            style: Styles.bold18,
                          ),
                        ],
                      ),
                      NewsList(state.news.articles),
                    ],
                  );
                } else if (state is NewsEmpty) {
                  return const NoResultFound();
                } else if (state is NewsError) {
                  return SomethingWentWrong(
                    onRetry: () => BlocProvider.of<NewsBloc>(context)
                        .add(const GetTopNews()),
                  );
                } else {
                  return const Loader();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<SourcesBloc, SourcesState>(
        builder: (context, state) {
          if (state is SourcesLoaded) {
            return FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (_context) => state.sources.sources.isEmpty
                      ? SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              '${Strings.noSourcesFound} ${Storage.getCountry()}',
                              style: Styles.bold20,
                            ),
                          ),
                        )
                      : MultiSelectBottomSheet<Source>(
                          title: const Text(
                            Strings.filterBySources,
                            style: Styles.bold20,
                          ),
                          items: state.sources.sources
                              .map((e) => MultiSelectItem(e, e.name))
                              .toList(),
                          initialValue: selectedSources,
                          onConfirm: (values) {
                            var source = "";
                            selectedSources = values;
                            for (var element in values) {
                              source += '${element.id},';
                            }
                            selectedSources.isEmpty
                                ? BlocProvider.of<NewsBloc>(context)
                                    .add(const GetTopNews())
                                : BlocProvider.of<NewsBloc>(context)
                                    .add(GetSourceNews(source));
                          },
                        ),
                );
              },
              child: const Icon(Icons.filter_alt_outlined),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
