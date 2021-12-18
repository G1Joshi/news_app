import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:news_app/config/secrets.dart';
import 'package:news_app/config/sharedprefs.dart';
import 'package:news_app/data/models/source_model.dart';

class SourcesAPI {
  Future<Sources> getSources() async {
    late Response response;
    try {
      response = await get(
        Uri.parse(
            "${API.baseUrl}/top-headlines/sources?country=${Preferences.getCountryCode()}"),
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
