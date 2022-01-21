import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app_binding.dart';
import 'data/values/constants.dart';
import 'data/values/env.dart';
import 'routes/app_pages.dart';
import 'theme/app_theme.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Env.title,
      navigatorKey: GlobalKeys.navigationKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.fade,
      initialBinding: AppBinding(),
    );
  }
}
