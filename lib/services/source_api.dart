import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import 'package:news_app/models/source_model.dart';
import 'package:news_app/utils/secrets.dart';
import 'package:news_app/utils/storage.dart';

class SourcesAPI {
  Future<Sources> getSources() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines/sources?country=${Storage.getCountryCode()}"),
        headers: {
          HttpHeaders.authorizationHeader: API.key,
        },
      );
    } catch (e) {
      throw Exception('Null');
    }
    if (response.statusCode == 200) {
      final body = Sources.fromJson(jsonDecode(response.body));
      if (body.status == 'ok') {
        return body;
      } else {
        throw Exception('Empty');
      }
    } else {
      throw Exception('Error');
    }
  }
}
