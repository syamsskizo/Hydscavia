import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/domain/entities/product.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';
import 'package:google_fonts/google_fonts.dart';
// Jangan lupa import model product lo di sini, misal:
// import 'package:flutter_application_1/features/home/domain/models/product.dart';

class FeaturedItems extends StatelessWidget {
  const FeaturedItems({super.key});

  @override
  Widget build(BuildContext context) {
    // SEMUA kategori sekarang pake kurung siku [] biar seragam
    final featuredItems = [
      Product(
        id: '1',
        name: 'Hoodie',
        categories: ['Laki-laki'], // Dibungkus list biar gak error
        price: 120.00,
        imageUrl: 'assets/images/hoodie.png',
        images: ['assets/images/hoodie_2.png', 'assets/images/hoodie_3.png'],
        description: 'A comfortable modern hoodie for your style.',
        colors: ['#FF5733', '#33CFFF', '#FFC300'],
        isFavorite: false,
        specialOfferIds: ['offer1'],
      ),
      Product(
        id: '2',
        name: 'Jordan Shoes',
        categories: ['Laki-laki', 'Promo'],
        price: 200.00,
        imageUrl: 'assets/images/jordan.png',
        images: ['assets/images/jordan.png', 'assets/images/jordan.png'],
        description: 'Classic Jordan shoes for basketball or daily wear.',
        colors: ['#A0522D', '#CD853F', '#D2B48C'],
        isFavorite: false,
        specialOfferIds: ['offer3'],
      ),
      Product(
        id: '3',
        name: 'Stylish Sofa',
        categories: ['Promo'],
        price: 350.00,
        imageUrl: 'assets/images/5.png',
        images: ['assets/images/4.png', 'assets/images/3.png'],
        description: 'A stylish sofa that adds elegance to your space.',
        colors: ['#8E44AD', '#3498DB', '#2ECC71'],
        isFavorite: false,
        specialOfferIds: ['offer2'],
      ),
      Product(
        id: '4',
        name: 'Adidas Shoes',
        categories: ['Laki-laki', 'Perempuan', 'Anak-Anak'],
        price: 500.00,
        imageUrl: 'assets/images/adidas_shoe.png',
        images: [
          'assets/images/adidas_shoe.png',
          'assets/images/adidas_shoe.png',
        ],
        description: 'The ultimate Adidas shoes for every generation.',
        colors: ['#1ABC9C', '#F1C40F', '#E67E22'],
        isFavorite: false,
        specialOfferIds: ['offer4'],
      ),
    ];

    // Placeholder ini nanti lo ganti pake widget GridView biar barangnya muncul
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Item',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to featured item screen
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
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: featuredItems.length,
            itemBuilder: (context, index) {
              final product = featuredItems [index];
              return Container(
                margin: EdgeInsets.only(right: 16, left: index == 0 ? 0 : 10),
                child: ProductCard(
                  product: product,
                  onTap: () {},
                    // navigate to product detail screen

                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
