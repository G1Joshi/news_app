import 'package:flutter/material.dart';

import 'package:news_app/screens/category/category.dart';
import 'package:news_app/screens/landing/landing.dart';
import 'package:news_app/screens/loading/loading.dart';
import 'package:news_app/screens/news/news.dart';
import 'package:news_app/screens/search/search.dart';

class Routes {
  Routes._();

  static const String loading = '/loading';
  static const String landing = '/landing';
  static const String news = '/news';
  static const String search = '/search';
  static const String category = '/category';
  static const String story = '/story';

  static Map<String, WidgetBuilder> routes = {
    loading: (context) => const LoadingPage(),
    landing: (context) => const LandingPage(),
    news: (context) => const NewsPage(),
    search: (context) => const SearchPage(),
    category: (context) => const CategoryPage(),
    story: (context) => const NewsStory(),
  };
}
