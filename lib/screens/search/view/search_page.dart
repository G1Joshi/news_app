import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/screens/search/search.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/strings.dart';
import 'package:news_app/widgets/news_list.dart';
import 'package:news_app/widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  static String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Header(Strings.appName),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (q) {
                query = q;
                BlocProvider.of<SearchBloc>(context).searchNews(q);
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8),
                filled: true,
                isCollapsed: true,
                fillColor: kPrimaryColor.withOpacity(0.1),
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
                hintText: Strings.searchForNews,
                hintStyle: const TextStyle(height: 1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchNewsLoaded) {
                  return NewsList(state.news.articles);
                } else if (state is SearchNewsEmpty) {
                  return const NoResultFound();
                } else if (state is SearchNewsError) {
                  return SomethingWentWrong(
                    onRetry: () => BlocProvider.of<SearchBloc>(context)
                        .add(GetQueryNews(query)),
                  );
                } else {
                  return const Empty();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
