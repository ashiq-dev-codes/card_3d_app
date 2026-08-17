import 'package:card_3d_app/feature/product/model/product.dart';
import 'package:card_3d_app/feature/product/presentation/widget/product_card.dart';
import 'package:card_3d_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

const List<Product> _products = [
  Product(
    id: '1',
    category: 'SHOES',
    title: 'Nike ZOOM Vaporfly NEXT Premium',
    price: 254.99,
    imageAsset: 'assets/images/3d_shoe_4x.png',
  ),
  Product(
    id: '2',
    category: 'SHOES',
    title: 'Nike ZOOM Vaporfly NEXT Premium',
    price: 254.99,
    imageAsset: 'assets/images/3d_shoe_4x.png',
  ),
];

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Dynamic\n3D Flip Animation',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Elevate user interaction with our 3D flip animation '
                    'for cards, seamlessly blending innovation and '
                    'engagement into your design.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
            SizedBox(
              height: 345,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _products.length,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return ProductCard(product: _products[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 24),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
