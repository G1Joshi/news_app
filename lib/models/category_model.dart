class Category {
  Category({
    required this.image,
    required this.name,
  });

  final String image;
  final String name;

  static final List<Category> categories = [
    Category(
      image: "https://images.unsplash.com/photo-1520607162513-77705c0f0d4a",
      name: "business",
    ),
    Category(
      image: "https://images.unsplash.com/photo-1499364615650-ec38552f4f34",
      name: "entertainment",
    ),
    Category(
      image: "https://images.unsplash.com/photo-1457369804613-52c61a468e7d",
      name: "general",
    ),
    Category(
      image: "https://images.unsplash.com/photo-1498837167922-ddd27525d352",
      name: "health",
    ),
    Category(
      image: "https://images.unsplash.com/photo-1507413245164-6160d8298b31",
      name: "science",
    ),
    Category(
      image: "https://images.unsplash.com/photo-1471295253337-3ceaaedca402",
      name: "sports",
    ),
    Category(
      image: "https://images.unsplash.com/photo-1518770660439-4636190af475",
      name: "technology",
    ),
  ];
}
