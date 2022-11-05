import 'package:flutter/material.dart';

import 'package:news_app/models/country_model.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/utils/storage.dart';
import 'package:news_app/utils/strings.dart';
import 'package:news_app/utils/styles.dart';
import 'package:news_app/widgets/widgets.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Header(Strings.chooseYourLocation),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: Country.countries.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () async {
            await Storage.setCountry(Country.countries[index].name);
            await Storage.setCountryCode(Country.countries[index].code);
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.news,
              (route) => false,
            );
          },
          title: Text(
            Country.countries[index].name,
            style: Styles.primaryBold20,
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
