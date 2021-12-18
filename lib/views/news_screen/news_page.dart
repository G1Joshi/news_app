import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:news_app/config/constants.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/data/models/source_model.dart';
import 'package:news_app/logic/news_bloc/news_bloc.dart';
import 'package:news_app/logic/sources_bloc/sources_bloc.dart';
import 'package:news_app/views/components/country_list.dart';
import 'package:news_app/views/news_screen/news_tile.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  static List<Source> selectedSources = [];
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'News App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async => await showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: const [
                      Text(
                        'Choose your location',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Divider(),
                      CountryList(),
                    ],
                  ),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20,
                    color: secondaryColorLight,
                  ),
                  Text(
                    Preferences.getCountry(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: secondaryColorLight,
                    ),
                  )
                ],
              ),
            )
          ],
          elevation: 0,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) => TextField(
                  onSubmitted: (query) {
                    BlocProvider.of<NewsBloc>(context).add(GetQueryNews(query));
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
                    suffixIcon: const Icon(
                      Icons.search,
                    ),
                    hintText: 'Search for news...',
                    hintStyle: const TextStyle(height: 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoaded) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Top Headlines',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton(
                              isDense: true,
                              iconSize: 20,
                              value: Preferences.getSortBy(),
                              underline: const SizedBox.shrink(),
                              items: [
                                ['Popular', 'popularity'],
                                ['Relevance', 'relevancy'],
                                ['Latest', 'publishedAt'],
                              ]
                                  .map(
                                    (value) => DropdownMenuItem(
                                      value: value[1],
                                      child: Text(value[0]),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (newValue) async {
                                await Preferences.setSortBy(
                                    newValue.toString());
                                BlocProvider.of<NewsBloc>(context).add(
                                  GetSortedNews(newValue.toString()),
                                );
                              },
                            ),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.news.articles.length,
                          itemBuilder: (context, index) => NewsTile(
                            data: state.news.articles[index],
                          ),
                        ),
                      ],
                    );
                  } else if (state is NewsEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.file_copy,
                          size: 50,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'No result found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  } else if (state is NewsError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.signal_wifi_connected_no_internet_4,
                          size: 50,
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Something went wrong',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () => BlocProvider.of<NewsBloc>(context)
                              .add(const GetTopNews()),
                          child: const Text(
                            'Try again',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
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
                    builder: (_context) => MultiSelectBottomSheet<Source>(
                      title: const Text(
                        'Filter by sources',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
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
      ),
    );
  }
}
