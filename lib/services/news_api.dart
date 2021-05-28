import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:news_app/components/secrets.dart';
import 'package:news_app/models/news_model.dart';

class NewsAPI {
  Future<News> getData(String country) async {
    late Response response;
    try {
      response = await get(
        Uri.parse("https://newsapi.org/v2/top-headlines?country=$country"),
        headers: {
          HttpHeaders.authorizationHeader: '${API.key}',
        },
      );
    } catch (e) {
      throw Exception('Null');
    }
    if (response.statusCode == 200) {
      News body = News.fromJson(jsonDecode(response.body));
      if (body.status == "ok") {
        return body;
      } else {
        throw Exception('Empty');
      }
    } else {
      throw Exception('Error');
    }
  }
}
