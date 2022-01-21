import '../../base/base_reposiotry.dart';
import '../../modules/home_page/controllers/home_page_controller.dart';
import '../../utils/helper/exception_handler.dart';
import '../../utils/storage/storage_utils.dart';
import '../models/dto/response.dart';
import '../models/news_model.dart';
import '../models/source_model.dart';
import '../values/urls.dart';

class NewsRepository extends BaseRepositry {
  bool queryEmpty() {
    return HomePageController.queryController.text.isEmpty;
  }

  bool sourcesEmpty() {
    return HomePageController.source.isEmpty;
  }

  bool categoryEmpty() {
    return HomePageController.category == null;
  }

  Future<RepoResponse<News>> getNews() async {
    late String path;
    if (!queryEmpty() && !sourcesEmpty()) {
      path =
          "/top-headlines?sources=${HomePageController.source}&q=${HomePageController.queryController.text}&pageSize=10&page=${HomePageController.page}";
    } else if (!queryEmpty() && !categoryEmpty()) {
      path =
          "/top-headlines?country=${Storage.getCountryCode()}&category=${HomePageController.category}&q=${HomePageController.queryController.text}&pageSize=10&page=${HomePageController.page}";
    } else if (!queryEmpty()) {
      path =
          "/top-headlines?country=${Storage.getCountryCode()}&q=${HomePageController.queryController.text}&pageSize=10&page=${HomePageController.page}";
    } else if (!sourcesEmpty()) {
      path =
          "/top-headlines?sources=${HomePageController.source}&pageSize=10&page=${HomePageController.page}";
    } else if (!categoryEmpty()) {
      path =
          "/top-headlines?country=${Storage.getCountryCode()}&category=${HomePageController.category}&pageSize=10&page=${HomePageController.page}";
    } else {
      path =
          "/top-headlines?country=${Storage.getCountryCode()}&pageSize=10&page=${HomePageController.page}";
    }
    final response = await controller.get(path: path);
    return (response is APIException) || (response["status"] != "ok")
        ? RepoResponse(error: response)
        : RepoResponse(data: News.fromJson((response)));
  }

  Future<RepoResponse<News>> getTopNews() async {
    final response = await controller.get(path: URLs.topNews());
    return (response is APIException) || (response["status"] != "ok")
        ? RepoResponse(error: response)
        : RepoResponse(data: News.fromJson((response)));
  }

  Future<RepoResponse<News>> getQueryNews() async {
    final response = await controller.get(path: URLs.queryNews());
    return (response is APIException) || (response["status"] != "ok")
        ? RepoResponse(error: response)
        : RepoResponse(data: News.fromJson((response)));
  }

  Future<RepoResponse<News>> getSourceNews() async {
    final response = await controller.get(path: URLs.sourceNews());
    return (response is APIException) || (response["status"] != "ok")
        ? RepoResponse(error: response)
        : RepoResponse(data: News.fromJson((response)));
  }

  Future<RepoResponse<News>> getCategoryNews() async {
    final response = await controller.get(path: URLs.categoryNews());
    return (response is APIException) || (response["status"] != "ok")
        ? RepoResponse(error: response)
        : RepoResponse(data: News.fromJson((response)));
  }

  Future<RepoResponse<Sources>> getSources() async {
    final response = await controller.get(path: URLs.sources());
    return (response is APIException) || (response["status"] != "ok")
        ? RepoResponse(error: response)
        : RepoResponse(data: Sources.fromJson((response)));
  }
}
