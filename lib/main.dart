import 'package:flutter/material.dart';

import 'package:news_app/screens/app/app.dart';
import 'package:news_app/utils/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  runApp(const NewsApp());
}
