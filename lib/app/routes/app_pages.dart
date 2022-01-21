import 'package:get/get.dart';

import '../modules/home_page/bindings/home_page_binding.dart';
import '../modules/home_page/views/home_page_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/news_details/bindings/news_details_binding.dart';
import '../modules/news_details/views/news_details_view.dart';
import '../modules/news_page/bindings/news_page_binding.dart';
import '../modules/news_page/views/news_page_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => const HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_PAGE,
      page: () => const NewsPageView(),
      binding: NewsPageBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAILS,
      page: () => const NewsDetailsView(),
      binding: NewsDetailsBinding(),
    ),
  ];
}
