import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news_app/screens/category/category.dart';
import 'package:news_app/widgets/news_list.dart';
import 'package:news_app/widgets/widgets.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String;
    return BlocProvider(
      create: (context) => CategoryBloc()..add(GetCategoryNews(category)),
      child: CategoryView(category: category),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Header(category),
        actions: const [SearchButton()],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryNewsLoaded) {
                  return NewsList(state.news.articles);
                } else if (state is CategoryNewsEmpty) {
                  return const NoResultFound();
                } else if (state is CategoryNewsError) {
                  return SomethingWentWrong(
                    onRetry: () => BlocProvider.of<CategoryBloc>(context)
                        .add(GetCategoryNews(category)),
                  );
                } else {
                  return const Loader();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
