import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/domain/entities/product.dart';
import 'package:flutter_application_1/features/home/presentation/pages/product_detail_page.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/animated_list_item.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  final List<String> categories = [
    'Electronics',
    'Clothing',
    'Shoes',
    'Accessories',
    'Home Appliances',
    'Wearables',
  ];

  final List<Product> dummyItems = [
    Product(
      id: '1',
      name: 'Apple iPhone 14 Pro',
      category: 'Electronics',
      price: 1099.0,
      imageUrl:
          'assets/images/hoodie_3.png',
      images: [
        'assets/images/hoodie_3.png',
      ],
      description:
          'Apple iPhone 14 Pro with 128GB storage, A16 Bionic chip, Dynamic Island, and Pro Camera System.',
      colors: ['#1c1c1e', '#f5f5f7'],
      isFavorite: false,
      specialOfferIds: ['offer1'],
    ),
    Product(
      id: '2',
      name: 'Nike Air Max 270',
      category: 'Footwear',
      price: 150.0,
      imageUrl:
          'assets/images/book_shelf_2.png',
      images: [
        'assets/images/book_shelf_2.png',
      ],
      description:
          'Nike Air Max 270 with lightweight cushioning and a bold heel unit for all-day comfort.',
      colors: ['#000000', '#ffffff'],
    ),
    Product(
      id: '3',
      name: 'Samsung Galaxy Watch 6',
      category: 'Wearables',
      price: 299.99,
      imageUrl:
          'assets/images.dining_table_3.png',
      images: [
        'assets/images/dining_table_3.png',
      ],
      description:
          'Stay connected and track your health with the new Galaxy Watch 6. AMOLED display and up to 40 hours of battery life.',
      colors: ['#b0b0b0', '#333333'],
    ),
    Product(
      id: '4',
      name: 'Adidas Originals Backpack',
      category: 'Accessories',
      price: 65.0,
      imageUrl:
          'assets/images/adidas_shoe.png',
      images: [
        'assets/images/adidas_shoe.png',
      ],
      description:
          'Classic Adidas backpack with spacious compartments and minimalist design.',
      colors: ['#000000'],
    ),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String query = _searchController.text;

    final List<Product> filteredItems = dummyItems
        .where(
          (item) =>
              item.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(AppConstants.defaultPadding),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ), // BoxDecoration
                      child: const Icon(
                        Icons.arrow_back,
                        size: 20,
                      ),
                    ), // Container
                  ), // GestureDetector

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocus,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon:
                              _searchController.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                    )
                                  : null,
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: query.isEmpty
          ? _buildSuggestedSearches()
          : filteredItems.isEmpty
              ? _buildNoResults()
              : _buildSearchResults(filteredItems),
    ); // Scaffold
  }

 Widget _buildSearchResults(List<Product> items) {
  return GridView.builder(
    padding: EdgeInsets.all(AppConstants.defaultPadding),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
    ), // SliverGridDelegateWithFixedCrossAxisCount
    itemCount: items.length,
    itemBuilder: (context, index) {
      final item = items[index];

      return AnimatedListItem(
        index: index,
        isVertical: false,
        child: Hero(
          tag: 'search_${item.id}',
          child: ProductCard(
            product: item,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      ProductDetailPage(product: item),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) =>
                      FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  transitionDuration: Duration(milliseconds: 300),
                ), // PageRouteBuilder
              );
            },
          ), // ProductCard
        ), // Hero
      ); // AnimatedListItem
    },
  ); // GridView.builder
}

  Widget _buildNoResults() {
  return Center(
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
          'No items found',
          style: AppConstants.titleStyle.copyWith(
            color: Colors.grey[600],
            fontSize: 18,
          ),
        ), // Text

        const SizedBox(height: 8),

        Text(
          'Try searching with different keywords',
          style: AppConstants.bodyStyle.copyWith(
            color: Colors.grey[500],
          ),
        ), // Text
      ],
    ), // Column
  ); // Center
}

  Widget _buildSuggestedSearches() {
    final popularTerms = [
      'iPhone 14 Pro',
      'Nike Air Max',
      'Adidas Backpack',
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),

          Text(
            'Popular Searches',
            style: AppConstants.headingStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
           children: popularTerms.map((term) {
  return _buildSuggestionChip(
    label: term,
    onTap: () {
      _searchController.text = term;
      setState(() {});
    },
    icon: _getSearchTermIcon(term),
  );
}).toList(),
          ), // Wrap
        ],
      ), // Column
    ); // SingleChildScrollView
  }

  IconData _getSearchTermIcon(String term) {
  if (term.toLowerCase().contains('iphone')) {
    return Icons.phone_iphone;
  }

  if (term.toLowerCase().contains('nike')) {
    return Icons.directions_run;
  }

  if (term.toLowerCase().contains('smartwatch')) {
    return Icons.watch;
  }

  if (term.toLowerCase().contains('backpack')) {
    return Icons.backpack;
  }

  return Icons.search_rounded;
}

  

  Widget _buildSuggestionChip({
    required String label,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(12),
          ), // BoxDecoration
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: AppConstants.primaryColor.withValues(
                  alpha: 0.7,
                ),
              ),

              const SizedBox(width: 8),

              Text(
                label,
                style: GoogleFonts.outfit(
                  color: Colors.grey[800],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ), // Text
            ],
          ), // Row
        ),
      ),
    );
  }

 IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'electronics':
        return Icons.electrical_services;
      case 'clothing':
        return Icons.checkroom;
      case 'shoes':
        return Icons.directions_walk;
      case 'accessories':
        return Icons.backpack;
      case 'home appliances':
        return Icons.kitchen;
      case 'wearables':
        return Icons.watch;
      default:
        return Icons.category;
    }
  }
}