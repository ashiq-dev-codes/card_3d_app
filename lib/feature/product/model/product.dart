import 'dart:math' as math;

import 'package:flutter/widgets.dart';

const double kProductImageRotationDegrees = 14.02;

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

/// Animates the product image's rotation across the flight instead of
/// snapping it straight: tilted in the card, level on the details page.
HeroFlightShuttleBuilder productImageFlightShuttleBuilder(String imageAsset) {
  return (
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    const double tiltedAngle = -kProductImageRotationDegrees * math.pi / 180;
    final bool isPush = flightDirection == HeroFlightDirection.push;
    final double fromAngle = isPush ? tiltedAngle : 0;
    final double toAngle = isPush ? 0 : tiltedAngle;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // On push `animation` runs 0 -> 1, but on pop it runs 1 -> 0
        // (see HeroFlightDirection.pop). Normalize both to a 0 (flight
        // start, "from" state) -> 1 (flight end, "to" state) progress.
        final double rawProgress = isPush
            ? animation.value
            : 1 - animation.value;
        final double progress = Curves.easeInOut.transform(
          rawProgress.clamp(0.0, 1.0),
        );
        final double angle = fromAngle + (toAngle - fromAngle) * progress;
        return Transform.rotate(angle: angle, child: child);
      },
      child: Image.asset(imageAsset, fit: BoxFit.contain),
    );
  };
}
