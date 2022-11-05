import 'package:flutter/material.dart';

import 'package:news_app/models/country_model.dart';
import 'package:news_app/utils/constants.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/utils/storage.dart';
import 'package:news_app/utils/strings.dart';
import 'package:news_app/utils/styles.dart';

class CountryList extends StatelessWidget {
  const CountryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async => await showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              const Text(
                Strings.chooseYourLocation,
                style: Styles.bold20,
              ),
              const Divider(),
              ListView.builder(
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
            ],
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            size: 20,
            color: kSecondaryColor,
          ),
          Text(
            Storage.getCountry(),
            style: Styles.secondary16,
          )
        ],
      ),
    );
  }
}
