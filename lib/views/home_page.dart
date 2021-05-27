import 'package:flutter/material.dart';
import 'package:news_app/components/countries.dart';
import 'package:news_app/views/news_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News 24x7',
          style: Theme.of(context).textTheme.headline5,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: Countries.countries.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) => ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NewsPage(country: Countries.countries[index].code),
            ),
          ),
          leading: Icon(
            Icons.flag,
          ),
          title: Text(
            Countries.countries[index].name,
            style: Theme.of(context).textTheme.headline6,
          ),
          trailing: Icon(
            Icons.double_arrow_rounded,
          ),
        ),
      ),
    );
  }
}
