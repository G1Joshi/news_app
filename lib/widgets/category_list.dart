import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:news_app/models/category_model.dart';
import 'package:news_app/utils/routes.dart';
import 'package:news_app/utils/styles.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: Category.categories.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              Navigator.pushNamed(
                context,
                Routes.category,
                arguments: Category.categories[index].name,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: Category.categories[index].image,
                      placeholder: (_, __) => Center(
                        child: Container(color: Colors.black54),
                      ),
                      width: 150,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black54,
                    ),
                    child: Center(
                      child: Text(
                        Category.categories[index].name.toUpperCase(),
                        style: Styles.whiteBold16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
