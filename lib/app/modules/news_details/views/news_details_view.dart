import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../theme/styles.dart';
import '../controllers/news_details_controller.dart';

class NewsDetailsView extends GetView<NewsDetailsController> {
  const NewsDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments.source.name,
          style: Styles.tsBold20,
        ),
        centerTitle: false,
      ),
      body: WebView(
        initialUrl: Get.arguments.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
