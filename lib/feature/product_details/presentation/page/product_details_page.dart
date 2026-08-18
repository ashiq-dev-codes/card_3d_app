import 'package:card_3d_app/feature/product/model/product.dart';
import 'package:card_3d_app/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

const List<String> _kSizes = ['5', '6', '7', '8', '9'];

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedSizeIndex = 2;
  bool _isWishlisted = false;

  Product get product => widget.product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(backgroundColor: AppColors.whiteColor),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category,
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.title,
                      style: const TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          r'$',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Text(
                          product.price.toStringAsFixed(2),
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            fontSize: 26,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 280,
                      child: Image.asset(
                        product.imageAsset,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'SELECT SIZE',
                      style: TextStyle(
                        color: AppColors.gray600,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < _kSizes.length; i++)
                          _SizeChip(
                            label: _kSizes[i],
                            selected: i == _selectedSizeIndex,
                            onTap: () => setState(() => _selectedSizeIndex = i),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _isWishlisted = !_isWishlisted),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.accent, width: 1.5),
                        borderRadius: BorderRadius.circular(16),
                        color: _isWishlisted
                            ? AppColors.accent.withValues(alpha: 0.1)
                            : Colors.transparent,
                      ),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 1, end: _isWishlisted ? 1.2 : 1.0),
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        builder: (context, scale, child) =>
                            Transform.scale(scale: scale, child: child),
                        child: Icon(
                          LucideIcons.heart,
                          color: _isWishlisted
                              ? AppColors.error600
                              : AppColors.accent,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Added size ${_kSizes[_selectedSizeIndex]} to cart',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Container(
                        height: 56,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.shoppingBasket,
                              color: AppColors.whiteColor,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'ADD TO CART',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SizeChip extends StatelessWidget {
  const _SizeChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        width: 52,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.chipBackground,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.whiteColor : AppColors.gray700,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
