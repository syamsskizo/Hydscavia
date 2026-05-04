import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/data/dummy_product.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/animated_list_item.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/custom_search_bar.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/featured_items.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/header.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/special_offer_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  final void Function(int) onNavigateToTab;

  const HomePage({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(
                top: 16,
                left: AppConstants.defaultPadding,
                right: AppConstants.defaultPadding,
                bottom: AppConstants.defaultPadding,
              ),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    onCartTap: () {
                      onNavigateToTab(1); // Index 1 adalah Cart
                    },
                  ),
                  const SizedBox(height: 20),
                  const CustomSearchBar(),
                  const SizedBox(height: 20),
                  _buildCategoryFilter(context),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: FeaturedItems()),
          const SliverToBoxAdapter(child: SpecialOfferWidget()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(AppConstants.defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Product',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //navogate yo all product
                    },
                    child: Text(
                      'View All',
                      style: GoogleFonts.outfit(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildStaticProductGrid(),
        ],
      ),
    );
  }

  Widget _buildStaticProductGrid() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = dummyProducts[index];
          return AnimatedListItem(
            index: index,
            isVertical: false,
            child: ProductCard(
              product: product,
              onTap: () {
                // Navigate to detail screen
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ProductDetailPage(product: product),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 300), 
                  ),
                );
              },
            ),
          );
        }, childCount: dummyProducts.length),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    // List sudah dibenerin biar gak jadi satu kalimat panjang
    final categories = ['Promo', 'All', 'Laki-laki', 'Perempuan', 'Anak-anak'];
    const selectedCategory = 'All';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Kategori',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories.map((category) {
              final isSelected = category == selectedCategory;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    // Nanti ganti ke StatefulWidget biar bisa setState
                  },
                  child: _categoryButton(category, isSelected),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _categoryButton(String label, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppConstants.primaryColor : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(14),
        boxShadow: isSelected
            ? [
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}
