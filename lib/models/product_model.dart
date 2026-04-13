class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String image;
  final List<Nutrition> nutrition;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
    required this.nutrition,
  });
}

class Nutrition {
  final String name;
  final String value;

  Nutrition({required this.name, required this.value});
}
