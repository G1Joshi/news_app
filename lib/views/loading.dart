import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/country_controller.dart';
import 'package:news_app/views/home_page.dart';
import 'package:news_app/views/news_screen/news_page.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CountryController>(
      init: CountryController(),
      builder: (controller) {
        if (controller.countrySet.isTrue) {
          return NewsPage();
        } else {
          return const HomePage();
        }
      },
    );
  }
}
