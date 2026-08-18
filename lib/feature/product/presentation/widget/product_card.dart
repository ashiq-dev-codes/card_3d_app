import 'dart:math' as math;

import 'package:card_3d_app/feature/product/model/product.dart';
import 'package:card_3d_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

const double _kImageRotationDegrees = 14.02;

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 23.33),
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
                  padding: EdgeInsets.all(6.67),
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
          Flexible(
            child: Transform.rotate(
              angle: -_kImageRotationDegrees * math.pi / 180,
              child: Image.asset(product.imageAsset, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}
