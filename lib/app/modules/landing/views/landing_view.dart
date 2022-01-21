import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/country_model.dart';
import '../../../data/values/strings.dart';
import '../../../theme/styles.dart';
import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.chooseLocation,
          style: Styles.tsBold24,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: Country.countries.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () => controller.setCountry(index),
          title: Text(
            Country.countries[index].name,
            style: Styles.tsPrimaryDarkBold20,
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
