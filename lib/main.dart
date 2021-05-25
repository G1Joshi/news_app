import 'package:flutter/material.dart';
import 'package:news_app/views/home_page.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News 24x7',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xffddeeff),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffd0e0f0),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xff102030),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff112233),
        ),
      ),
      home: HomePage(),
    );
  }
}
