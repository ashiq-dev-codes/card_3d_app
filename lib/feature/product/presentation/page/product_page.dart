import 'package:card_3d_app/feature/product/model/product.dart';
import 'package:card_3d_app/feature/product/presentation/widget/explore_more_button.dart';
import 'package:card_3d_app/feature/product/presentation/widget/product_card.dart';
import 'package:card_3d_app/feature/product/presentation/widget/product_header.dart';
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
          children: [
            const ProductHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Dynamic\n3D Flip Animation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Elevate user interaction with our 3D flip animation '
                        'for cards, seamlessly blending innovation and '
                        'engagement into your design.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: AppColors.textOnDark,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 520,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.86),
                        padEnds: false,
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              left: index == 0 ? 24 : 12,
                              right: 12,
                            ),
                            child: ProductCard(product: _products[index]),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    const ExploreMoreButton(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
