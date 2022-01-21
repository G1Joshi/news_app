class Category {
  Category({
    required this.code,
    required this.name,
  });

  final String code;
  final String name;

  static final List<Category> categories = [
    Category(
      code: "business",
      name: "Business",
    ),
    Category(
      code: "entertainment",
      name: "Entertainment",
    ),
    Category(
      code: "general",
      name: "General",
    ),
    Category(
      code: "health",
      name: "Health",
    ),
    Category(
      code: "science",
      name: "Science",
    ),
    Category(
      code: "sports",
      name: "Sports",
    ),
    Category(
      code: "technology",
      name: "Technology",
    ),
  ];
}
