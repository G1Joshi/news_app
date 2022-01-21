part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const LANDING = _Paths.LANDING;
  static const HOME_PAGE = _Paths.HOME_PAGE;
  static const NEWS_PAGE = _Paths.NEWS_PAGE;
  static const NEWS_DETAILS = _Paths.NEWS_DETAILS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const LANDING = '/landing';
  static const HOME_PAGE = '/home-page';
  static const NEWS_PAGE = '/news-page';
  static const NEWS_DETAILS = '/news-details';
}
