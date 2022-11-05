import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:news_app/utils/styles.dart';
import 'package:news_app/widgets/widgets.dart';

class NewsStory extends StatefulWidget {
  const NewsStory({Key? key}) : super(key: key);

  @override
  State<NewsStory> createState() => _NewsStoryState();
}

class _NewsStoryState extends State<NewsStory> {
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          data[0],
          style: Styles.bold20,
        ),
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: loading ? 0 : 1,
            child: WebView(
              onPageFinished: (url) => setState(() => loading = false),
              initialUrl: data[1],
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          if (loading) const Loader(),
        ],
      ),
    );
  }
}
