import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/config/constants.dart';
import 'package:news_app/views/loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        fontFamily: 'Helvetica',
        scaffoldBackgroundColor: secondaryColorLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColorLight,
          foregroundColor: secondaryColorLight,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColorDark,
          secondary: primaryColorLight,
        ),
      ),
      home: const Loading(),
    );
  }
}
