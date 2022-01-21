import '../../modules/home_page/controllers/home_page_controller.dart';
import '../../utils/storage/storage_utils.dart';

class URLs {
  URLs._();

  static topNews() => "/top-headlines?country=${Storage.getCountryCode()}";
  static queryNews() =>
      "/top-headlines?country=${Storage.getCountryCode()}&q=${HomePageController.queryController.text}";
  static sourceNews() => "/top-headlines?sources=${HomePageController.source}";
  static categoryNews() =>
      "/top-headlines?country=${Storage.getCountryCode()}&category=${HomePageController.category}";
  static sources() =>
      "/top-headlines/sources?country=${Storage.getCountryCode()}";
}
