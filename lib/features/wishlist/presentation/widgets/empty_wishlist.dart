import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              "Your wishlist is empty",
              textAlign: TextAlign.center, // Bikin teks di tengah
              style: AppConstants.titleStyle.copyWith(
                color: Colors.grey[600],
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Save items you like by tapping the heart icon",
              textAlign: TextAlign.center, // Bikin teks di tengah
              style: AppConstants.titleStyle.copyWith(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            )
          ],
        ),
      
    );
  }
}