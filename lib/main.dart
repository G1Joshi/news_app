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
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blueGrey,
        primaryColor: Color(0xff667788),
        scaffoldBackgroundColor: Color(0xffddeeff),
        cardColor: Color(0xffd0e0f0),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffd0e0f0),
          iconTheme: IconThemeData(
            color: Color(0xff667788),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xff667788),
          size: 30,
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
            color: Color(0xff708090),
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Color(0xff667788),
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Color(0xff192939),
            fontWeight: FontWeight.w700,
          ),
          bodyText2: TextStyle(
            color: Color(0xff192939),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        primaryColor: Color(0xffaabbcc),
        scaffoldBackgroundColor: Color(0xff102030),
        cardColor: Color(0xff192939),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff112233),
          iconTheme: IconThemeData(
            color: Color(0xffaabbcc),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xffaabbcc),
          size: 30,
        ),
        textTheme: TextTheme(
          headline5: TextStyle(
            color: Color(0xffa0b0c0),
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Color(0xffaabbcc),
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Color(0xffd0e0f0),
            fontWeight: FontWeight.w700,
          ),
          bodyText2: TextStyle(
            color: Color(0xffd0e0f0),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}
