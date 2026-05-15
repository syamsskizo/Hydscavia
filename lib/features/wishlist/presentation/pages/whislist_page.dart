import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/domain/entities/product.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/animated_list_item.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';
import 'package:flutter_application_1/features/wishlist/presentation/widgets/empty_wishlist.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = true;
    final List<Product> wishlistItems = [
      Product(
        id: '1',
        name: 'Modern Chair',
        description: 'enak di pakai',
        imageUrl: 'assets/images/queen_bed.png',
        images: [],
        price: 199.99,
        category: 'Promo',
        colors: [],
      ),
      Product(
        id: '2',
        name: 'Elegant Lamp',
        description: 'Terang Bingitz',
        imageUrl: 'assets/images/wardrobe.png',
        images: [],
        price: 199.99,
        category: 'Promo',
        colors: [],
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              left: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
              bottom: AppConstants.defaultPadding,
            ),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Whislist",
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (wishlistItems.isNotEmpty)
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (!isLoggedIn) {
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
                          "Sign in to view your wishlist",
                          style: AppConstants.titleStyle.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Create an account to save your favorite items",
                          style: AppConstants.bodyStyle.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppConstants.primaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(12),
                            ),
                          ),
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (wishlistItems.isEmpty) {
                  return EmptyWishlist();
                }

                return GridView.builder(
                  padding: EdgeInsets.all(AppConstants.defaultPadding),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: wishlistItems.length,
                  itemBuilder: (context, index) {
                    final item = wishlistItems[index];
                    return AnimatedListItem(
                      index: index,
                      isVertical: false,
                      child: Hero(
                        tag: 'wishlist_${item.id}',
                        child: ProductCard(product: item, onTap: () {}),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
