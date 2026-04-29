import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/data/dummy_product.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/animated_list_item.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';
import 'package:google_fonts/google_fonts.dart';

// Pastiin lo import dua file ini ya, soalnya dipake di dalem GridView
// import 'package:flutter_application_1/features/home/presentation/widgets/animated_list_item.dart';
// import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';

class CategoryProductsPage extends StatelessWidget {
  final String category;

  const CategoryProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // --- LOGIC FILTERING PRODUK LO ---
    final products = category == 'All'
        ? dummyProducts
        : dummyProducts
            .where((p) => p.categories.any((c) => c.toLowerCase() == category.toLowerCase()))
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 8),
            Expanded(
              child: products.isEmpty
                  ? _EmptyCategoryState(category: category)
                  : GridView.builder(
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.60, // Sesuai video
                        crossAxisSpacing: 16,   // Sesuai video
                        mainAxisSpacing: 16,    // Sesuai video
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final item = products[index]; // Di video pakenya 'item'
                        
                        // Sesuai persis sama baris 41-45 di video
                        return AnimatedListItem(
                          index: index,
                          isVertical: false,
                          child: ProductCard(product: item, onTap: () {}),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HEADER ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16, 
        vertical: 14,
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            category,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

// --- CLASS EMPTY STATE ---
class _EmptyCategoryState extends StatelessWidget {
  final String category;

  const _EmptyCategoryState({required this.category});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: [
          const Icon(Icons.inbox_outlined, size: 56, color: Colors.grey),
          const SizedBox(height: 12),
          Text(
            'No products found',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w700, 
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Try a different category or come back later.',
            style: GoogleFonts.outfit(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}