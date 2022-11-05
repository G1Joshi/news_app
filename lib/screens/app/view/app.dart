import 'package:flutter/material.dart';

import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/utils/strings.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      routes: Routes.routes,
      initialRoute: Routes.loading,
      theme: ThemeData(
        // useMaterial3: true,
        fontFamily: 'Helvetica',
        primaryColor: kPrimaryColor,
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: kSecondaryColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kPrimaryColor,
          secondary: kPrimaryColor,
        ),
      ),
    );
  }
}
