import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/domain/entities/product.dart';
import 'package:flutter_application_1/features/home/presentation/pages/product_detail_page.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/animated_list_item.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';

class FeaturedItemScreen extends StatefulWidget {
  const FeaturedItemScreen({super.key});

  @override
  State<FeaturedItemScreen> createState() => _FeaturedItemScreenState();
}

class _FeaturedItemScreenState extends State<FeaturedItemScreen> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  String selectedSortOption = 'Price Low to High';

  final List<String> sortOption = [
    'Price: Low to High',
    'Price: High to Low',
    'Name: A to Z',
    'Name: Z to A',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FeaturedItems = [
      Product(
        id: '1',
        name: 'Adidas Shoes',
        category: 'Anak-anak',
        price: 120.00,
        imageUrl: 'assets/images/adidas_shoe.png',
        images: [
          'assets/images/adidas_shoe.png',
          'assets/images/adidas_shoe_1.png',
        ],
        description: 'Comfortable sneakers perfect for everyday wear.',
        colors: ['#FF5733', '#33CFFF', '#FFC300'],
        isFavorite: false,
        specialOfferIds: ['offer1'],
      ),
      Product(
        id: '2',
        name: 'Stylish Sofa',
        category: 'Perempuan',
        price: 350.00,
        imageUrl:
            'assets/images/hoodie.png', // Di video emang agak aneh namanya, sesuaikan aja Syam
        images: [
          'assets/images/hoodie.png',
          'assets/images/hoodie_2.png',
          'assets/images/hoodie_3.png',
        ],
        description: 'A stylish sofa that adds elegance to your space.',
        colors: ['#8E44AD', '#3498DB', '#2ECC71'],
        isFavorite: false,
        specialOfferIds: ['offer2'],
      ),
      Product(
        id: '3',
        name: 'Wooden Table',
        category: 'Promo',
        price: 200.00,
        imageUrl: 'assets/images/3.png',
        images: [
          'assets/images/3.png',
          'assets/images/3.png', // Sesuai video dia duplikat gambarnya
        ],
        description: 'A strong wooden table suitable for dining or work.',
        colors: ['#A0522D', '#CD853F', '#D2B48C'],
        isFavorite: false,
        specialOfferIds: ['offer3'],
      ),
      Product(
        id: '4',
        name: 'Jordan Shoes',
        category: 'Laki-laki',
        price: 500.00,
        imageUrl: 'assets/images/jordan.png',
        images: ['assets/images/jordan.png', 'assets/images/jordan.png'],
        description: 'Iconic sneakers with style and comfort.',
        colors: ['#1ABC9C', '#F1C40F', '#E67E22'],
        isFavorite: false,
        specialOfferIds: ['offer4'],
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.only(left: 8),
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(CupertinoIcons.back, size: 22),
          ),
        ),
        title: Text('Featured Items', style: AppConstants.headingStyle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(FluentSystemIcons.ic_fluent_access_time_regular),
          ),
          SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          //search bar
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.defaultPadding,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Here...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
              ),

              // short dropdown and filter icon
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!),
                        borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius,
                        ),
                      ),
                      child: PopupMenuButton<String>(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        icon: Icon(CupertinoIcons.sort_up_circle_fill),
                        tooltip: 'Sort Options',
                        onSelected: (String value) {
                          setState(() {
                            selectedSortOption = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return sortOption.map((String option) {
                            return PopupMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList();
                        },
                      ),
                    ),

                    const SizedBox(width: 12),
                  ],
                ),
              ),
            ],
          ),

          // grid view
          Expanded(
            child: FeaturedItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: Colors.grey[400],
                        ),

                        const SizedBox(height: 16),
                        Text(
                          'No featured item available',
                          style: AppConstants.titleStyle.copyWith(
                            color: Colors.grey[600],
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    itemCount: FeaturedItems.length,
                    padding: EdgeInsets.all(AppConstants.defaultPadding),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final product = FeaturedItems[index];

                      return AnimatedListItem(
                        index: index,
                        isVertical: false,
                        child: Hero(
                          tag: 'featured_${product.id}',
                          child: ProductCard(
                            product: product,
                            onTap: () {
                              // navigate to product detail page
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => ProductDetailPage(product: product),
                                  transitionsBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                  transitionDuration: Duration(
                                    milliseconds: 300,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
