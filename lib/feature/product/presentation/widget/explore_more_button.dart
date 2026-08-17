import 'package:flutter/material.dart';

class ExploreMoreButton extends StatelessWidget {
  const ExploreMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white24),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Explore more',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.north_east, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
