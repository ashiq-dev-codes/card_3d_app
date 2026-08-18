import 'package:flutter/widgets.dart';

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

/// Renders the plain (unrotated) product image while its Hero is in flight,
/// regardless of whether the resting widget on either end is rotated.
HeroFlightShuttleBuilder productImageFlightShuttleBuilder(String imageAsset) {
  return (
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return Image.asset(imageAsset, fit: BoxFit.contain);
  };
}
