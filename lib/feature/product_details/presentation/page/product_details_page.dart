import 'dart:math' as math;

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

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
  int _selectedSizeIndex = 2;
  bool _isWishlisted = false;
  late final AnimationController _revealController;

  Product get product => widget.product;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  /// Fades and slides [child] up into place, staggered within the overall
  /// reveal by [start]/[end] so sections cascade in one after another.
  Widget _reveal(Widget child, {required double start, required double end}) {
    final animation = CurvedAnimation(
      parent: _revealController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

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
                    _reveal(
                      start: 0,
                      end: 0.6,
                      Column(
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _reveal(
                      start: 0.08,
                      end: 0.68,
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
                    ),
                    SizedBox(
                      height: 280,
                      child: _StretchyProductImage(
                        child: Hero(
                          tag: 'product-image-${product.id}',
                          createRectTween: (begin, end) =>
                              MaterialRectArcTween(begin: begin, end: end),
                          flightShuttleBuilder:
                              productImageFlightShuttleBuilder(
                                product.imageAsset,
                              ),
                          child: Image.asset(
                            product.imageAsset,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _reveal(
                      start: 0.16,
                      end: 0.76,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  onTap: () =>
                                      setState(() => _selectedSizeIndex = i),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _reveal(
              start: 0.24,
              end: 0.84,
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          setState(() => _isWishlisted = !_isWishlisted),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.accent,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: _isWishlisted
                              ? AppColors.accent.withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(
                            begin: 1,
                            end: _isWishlisted ? 1.2 : 1.0,
                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}

/// Wraps [child] with a draggable perspective tilt + stretch: dragging warps
/// the image like a physical 3D plane being pulled, springing back on release.
class _StretchyProductImage extends StatefulWidget {
  const _StretchyProductImage({required this.child});

  final Widget child;

  @override
  State<_StretchyProductImage> createState() => _StretchyProductImageState();
}

class _StretchyProductImageState extends State<_StretchyProductImage>
    with SingleTickerProviderStateMixin {
  static const double _maxDrag = 90;
  static const double _maxTiltRadians = 0.5;

  late final AnimationController _springController;
  Animation<Offset>? _springAnimation;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _springController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 700),
        )..addListener(() {
          final springAnimation = _springAnimation;
          if (springAnimation != null) {
            setState(() => _dragOffset = springAnimation.value);
          }
        });
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  // Rubber-band damping: resists more the further it's already stretched.
  // dart:math has no tanh, so it's expanded from exp() directly.
  double _damp(double delta) {
    final double e = math.exp(2 * delta / _maxDrag);
    final double tanh = (e - 1) / (e + 1);
    return _maxDrag * tanh;
  }

  void _onPanStart(DragStartDetails details) {
    _springController.stop();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset = Offset(
        _damp(_dragOffset.dx + details.delta.dx),
        _damp(_dragOffset.dy + details.delta.dy),
      );
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _springAnimation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _springController, curve: Curves.elasticOut),
        );
    _springController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final double nx = (_dragOffset.dx / _maxDrag).clamp(-1.0, 1.0);
    final double ny = (_dragOffset.dy / _maxDrag).clamp(-1.0, 1.0);
    final double intensity = ((nx.abs() + ny.abs()) / 2).clamp(0.0, 1.0);
    final double stretch = 1 + 0.16 * intensity;

    // Shifts from cyan toward violet/magenta as the drag moves horizontally,
    // giving the glow an iridescent, holographic-card feel instead of a flat
    // single-color halo.
    final double hue = 190 + ((nx + 1) / 2) * 130;
    final Color holoColor = HSVColor.fromAHSV(1, hue, 0.7, 1).toColor();

    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.0018)
      ..rotateX(-ny * _maxTiltRadians)
      ..rotateY(nx * _maxTiltRadians)
      ..scaleByDouble(stretch, stretch, stretch, 1);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Transform.translate(
            offset: _dragOffset * 0.25,
            child: Transform(
              alignment: Alignment.center,
              transform: matrix,
              child: ShaderMask(
                blendMode: BlendMode.softLight,
                shaderCallback: (bounds) {
                  final double sweep = 0.5 + nx * 0.35;
                  final double eased = Curves.easeOut.transform(intensity);
                  final Color sheenColor = Color.lerp(
                    Colors.white,
                    holoColor,
                    0.2,
                  )!;
                  final Color core = sheenColor.withValues(alpha: eased);
                  final Color soft = sheenColor.withValues(alpha: eased * 0.35);
                  return LinearGradient(
                    begin: Alignment(-1 + ny * 0.6, -1),
                    end: Alignment(1 + ny * 0.6, 1),
                    colors: [
                      Colors.transparent,
                      soft,
                      core,
                      soft,
                      Colors.transparent,
                    ],
                    stops: [
                      (sweep - 0.16).clamp(0.0, 1.0),
                      (sweep - 0.06).clamp(0.0, 1.0),
                      sweep.clamp(0.0, 1.0),
                      (sweep + 0.06).clamp(0.0, 1.0),
                      (sweep + 0.16).clamp(0.0, 1.0),
                    ],
                  ).createShader(bounds);
                },
                child: widget.child,
              ),
            ),
          ),
        ],
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
