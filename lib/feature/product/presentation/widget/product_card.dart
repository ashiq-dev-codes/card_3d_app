import 'dart:math' as math;

import 'package:animations/animations.dart';
import 'package:card_3d_app/feature/product/model/product.dart';
import 'package:card_3d_app/feature/product_details/presentation/page/product_details_page.dart';
import 'package:card_3d_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

const double _kImageRotationDegrees = 14.02;

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  VoidCallback? _openImage;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openImage?.call(),
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          width: 250,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 23.33),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.67),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.category,
                            style: TextStyle(
                              fontSize: 8,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(6.67),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.83,
                          color: AppColors.borderColor1,
                        ),
                        borderRadius: BorderRadius.circular(6.67),
                        color: AppColors.secondaryColor.withValues(alpha: 0.50),
                      ),
                      child: Icon(
                        LucideIcons.maximize2,
                        size: 13,
                        color: AppColors.iconColor1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6.67),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.67),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r'$',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Text(
                      product.price.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: OpenContainer<void>(
                  tappable: false,
                  transitionDuration: const Duration(milliseconds: 550),
                  transitionType: ContainerTransitionType.fadeThrough,
                  closedElevation: 0,
                  closedColor: AppColors.cardBackground,
                  middleColor: AppColors.whiteColor,
                  closedShape: const RoundedRectangleBorder(),
                  openColor: AppColors.whiteColor,
                  openBuilder: (context, action) =>
                      ProductDetailsPage(product: product),
                  closedBuilder: (context, action) {
                    _openImage = action;
                    return Transform.rotate(
                      angle: -_kImageRotationDegrees * math.pi / 180,
                      child: Image.asset(
                        product.imageAsset,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
