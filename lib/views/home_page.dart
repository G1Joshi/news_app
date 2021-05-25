import 'package:flutter/material.dart';
import 'package:news_app/components/countries.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News 24x7',
          style: TextStyle(
            color: Color(0xff708090),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: Countries.countries.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(
            Icons.flag,
            color: Color(0xff778899),
          ),
          title: Text(
            Countries.countries[index].name,
            style: TextStyle(
              color: Color(0xff778899),
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.double_arrow_rounded,
            color: Color(0xff778899),
          ),
        ),
      ),
    );
  }
}
