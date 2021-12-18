import 'package:flutter/material.dart';
import 'package:news_app/config/constants.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/data/models/country_model.dart';
import 'package:news_app/views/news_screen/news_page.dart';

class CountryList extends StatelessWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: Country.countries.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () async {
          await Preferences.setCountry(Country.countries[index].name);
          await Preferences.setCountryCode(Country.countries[index].code);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NewsPage(),
            ),
            (route) => false,
          );
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
    );
  }
}
