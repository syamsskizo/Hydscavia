import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/data/dummy_product.dart';
import 'package:flutter_application_1/features/home/presentation/pages/product_detail_page.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/animated_list_item.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  bool _isGridView = true; // default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'All Products',
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      // Benerin logic pemanggilan view
      body: _isGridView ? _buildGridView() : _buildListView(),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.64,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        final product = dummyProducts[index];
        return AnimatedListItem(
          index: index,
          isVertical: false,
          child: Hero(
            tag: 'Product_${product.id}', // Diganti huruf kecil
            child: ProductCard(
              product: product, // Diganti huruf kecil
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, _, _) => ProductDetailPage(
                      product: product,
                    ), // Ditambahin koma & huruf kecil
                    transitionsBuilder:
                        (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) => // Parameter diganti huruf kecil
                            FadeTransition(opacity: animation, child: child),
                    transitionDuration: const Duration(
                      milliseconds: 300,
                    ), // Diganti ke milliseconds
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        final product = dummyProducts[index];
        return AnimatedListItem(
          index: index,
          isVertical: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  AppConstants.defaultBorderRadius,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, _, _) => ProductDetailPage(
                        product: product, // Pakai p kecil
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                      transitionDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                child: Row(
                  children: [
                    // Product Image
                    Container(
                      width: 140,
                      decoration: BoxDecoration(
                        color: AppConstants.greyColor,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(
                            AppConstants.defaultBorderRadius,
                          ),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(
                            AppConstants.defaultBorderRadius,
                          ),
                        ),
                        child: Image.asset(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ), // Pakai p kecil
                      ),
                    ),
                    // Product Detail
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.name, // Pakai p kecil
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                            
                              product.category,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}', // Pakai p kecil
                              style: GoogleFonts.outfit(
                                fontSize: 15,
                                color: AppConstants.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Favorite Icon
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
