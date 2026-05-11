import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/domain/entities/product.dart';
import 'package:flutter_application_1/features/home/domain/entities/special_offer.dart';
import 'package:flutter_application_1/features/home/presentation/pages/product_detail_page.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/animated_list_item.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecialOffersPage extends StatefulWidget {
  final String offerId;

  const SpecialOffersPage({super.key, required this.offerId});

  @override
  State<SpecialOffersPage> createState() => _SpecialOffersPageState();
}

class _SpecialOffersPageState extends State<SpecialOffersPage> {
  // 1. Deklarasi offer dipindah pakai late dan masuk initState
  late final SpecialOffer offer;

  @override
  void initState() {
    super.initState();
    offer = SpecialOffer(
      id: widget.offerId, // Fixed: Pakai widget.offerId
      title: 'Summer Sale',
      description: 'Gila ini keren banget sampe bang inok ngomong cihuy!',
      discountPercentage: 20,
      startDate: DateTime(2026, 3, 1),
      endDate: DateTime(2026, 5, 26), // Fixed: Tambah koma di sini
      applicableCategories: ['Perempuan'],
      applicableProductIds: ['1', '2'],
      minimumPurchaseAmount: 100.0,
      isActive: true,
    );
  }

  final dummyProducts = [
    Product(
      id: '1',
      name: 'iPhone 14 Pro',
      category: 'Electronics',
      price: 1000,
      imageUrl: 'assets/images/adidas_shoe.png',
      images: ['assets/images/adidas_shoe.png'],
      description: 'Apple iPhone 14 Pro',
      colors: ['#000000'],
      isFavorite: false,
      specialOfferIds: ['summer'],
    ),
    Product(
      id: '2',
      name: 'Samsung Smartwatch',
      category: 'Electronics',
      price: 200,
      imageUrl: 'assets/images/jordan.png',
      images: ['assets/images/jordan.png'],
      description: 'Latest Galaxy Watch',
      colors: ['#000000'],
      isFavorite: false,
      specialOfferIds: ['summer'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(
                      AppConstants.defaultBorderRadius),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.title,
                      style: GoogleFonts.outfit(
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      offer.description,
                      style: GoogleFonts.outfit(
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${offer.discountPercentage.toStringAsFixed(0)}% OFF',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = dummyProducts[index];
                  return AnimatedListItem(
                    index: index,
                    isVertical: false,
                    child: Hero(
                      tag: 'special_offer_${item.id}',
                      child: ProductCard(
                        product: item,
                        onTap: () {
                          // 2. Fixed: Penulisan Navigator dan PageRouteBuilder dirapihkan
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  ProductDetailPage(product: item),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation, // Fixed: Langsung masukin animation, ga perlu widget Opacity lagi
                                  child: child,
                                );
                              },
                              transitionDuration: const Duration(milliseconds: 300), // Fixed: Pakai titik dua (:) bukan titik koma (;)
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                childCount: dummyProducts.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}