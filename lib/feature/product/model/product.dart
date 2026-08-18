class Product {
  const Product({
    required this.id,
    required this.category,
    required this.title,
    required this.price,
    required this.imageAsset,
  });

  final String id;
  final String category;
  final String title;
  final double price;
  final String imageAsset;
}
