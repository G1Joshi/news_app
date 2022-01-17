import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/config/constants.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/models/country_model.dart';
import 'package:news_app/views/news_screen/news_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose your location',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: Country.countries.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () async {
            await Preferences.setCountry(Country.countries[index].name);
            await Preferences.setCountryCode(Country.countries[index].code);
            Get.off(() => NewsPage());
          },
          title: Text(
            Country.countries[index].name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColorDark,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_right,
            size: 30,
          ),
        ),
      ),
    );
  }
}
