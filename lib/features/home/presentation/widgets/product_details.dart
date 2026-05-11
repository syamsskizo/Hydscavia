import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/domain/entities/product.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/custom_primary_button.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/product_card.dart'; // Tambahan import
import 'package:flutter_application_1/features/home/presentation/pages/product_detail_page.dart'; // Tambahan import
import 'package:google_fonts/google_fonts.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  final Animation<double> contentAnimation;
  const ProductDetails({
    super.key,
    required this.product,
    required this.contentAnimation,
  });
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? _selectedColor;
  double _userRating = 0;

  // Deklarasi variabel loading button yang sebelumnya hilang
  bool _isAddingToCart = false;
  final bool _isBuyingNow = false;

  final TextEditingController _reviewController = TextEditingController();
  late List<Review> _reviews;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.product.colors.isNotEmpty
        ? widget.product.colors[0]
        : "#FFFFFF";

    _reviews = List<Review>.from(widget.product.reviews);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name & Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          buildStarRating(_averageRating(), size: 16),
                          const SizedBox(width: 8),
                          Text(
                            '${_averageRating().toStringAsFixed(1)} (${_reviews.length} reviews)',
                            style: GoogleFonts.outfit(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (widget.product.hasSpecialOffer) ...[
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: GoogleFonts.outfit(
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${(widget.product.price * 0.9).toStringAsFixed(2)}',
                        style: GoogleFonts.outfit(
                          color: AppConstants.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: GoogleFonts.outfit(
                          color: AppConstants.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              // Pakai .categories (ada s-nya) lalu digabung pakai koma
              widget.product.category,
              style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 24),
            Text(
              'Description',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Select Color',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: widget.product.colors.map((colorHex) {
                final isSelected = colorHex == _selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = colorHex),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppConstants.primaryColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(colorHex.replaceFirst('#', '0xFF')),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // Input Review Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _averageRating().toStringAsFixed(1),
                            style: GoogleFonts.outfit(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              '/ 5',
                              style: GoogleFonts.outfit(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      buildStarRating(_averageRating(), size: 18),
                      const SizedBox(height: 6),
                      Text(
                        '${_reviews.length} reviews',
                        style: GoogleFonts.outfit(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 68,
                    child: VerticalDivider(color: Colors.grey[300], width: 1),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add your review',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(5, (index) {
                            final int starIndex = index + 1;
                            return InkWell(
                              onTap: () => setState(
                                () => _userRating = starIndex.toDouble(),
                              ),
                              child: Icon(
                                _userRating >= starIndex
                                    ? Icons.star
                                    : Icons.star_border,
                                color: Colors.amber,
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _reviewController,
                          minLines: 2,
                          maxLines: 3,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Share your experience...',
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey[100],
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed:
                                (_userRating == 0 ||
                                    _reviewController.text.trim().isEmpty)
                                ? null
                                : () {
                                    final newReview = Review(
                                      username: 'You',
                                      rating: _userRating,
                                      comment: _reviewController.text.trim(),
                                      createdAt: DateTime.now(),
                                    );
                                    setState(() {
                                      _reviews = [newReview, ..._reviews];
                                      _userRating = 0;
                                      _reviewController.clear();
                                    });
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstants.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: GoogleFonts.outfit(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Customer Reviews List
            if (_reviews.isNotEmpty) ...[
              Text(
                'Customer reviews',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _reviews.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final Review r = _reviews[index];
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: AppConstants.primaryColor
                                  .withOpacity(0.1),
                              child: Text(
                                r.username.isNotEmpty ? r.username[0] : '?',
                                style: GoogleFonts.outfit(
                                  color: AppConstants.primaryColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    r.username,
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    _formatDate(r.createdAt),
                                    style: GoogleFonts.outfit(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            buildStarRating(
                              r.rating,
                              size: 14,
                            ), // typo 14zz di fix
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          r.comment,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
            const SizedBox(height: 10),
            // Action Buttons Row
            Row(
              children: [
                // Add to Cart Button
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: OutlinedButton(
                      onPressed: _isAddingToCart
                          ? null
                          : () {
                              setState(() => _isAddingToCart = true);
                              Future.delayed(
                                const Duration(milliseconds: 800),
                                () {
                                  if (!mounted) return;
                                  setState(() => _isAddingToCart = false);
                                  // Nanti fungsi showCustomToastOverlay bisa diaktifkan lagi
                                  // pastikan udah diimport ya
                                },
                              );
                            },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppConstants.primaryColor,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.defaultBorderRadius,
                          ),
                        ),
                      ),
                      child: _isAddingToCart
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppConstants.primaryColor,
                                ),
                              ),
                            )
                          : Text(
                              'Add to Cart',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.primaryColor,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Buy Now Button
                Expanded(
                  child: CustomPrimaryButton(
                    isLoading: _isBuyingNow,
                    onPressed: () {
                      // _buyNow();
                    },
                    height: 56,
                    borderRadius: AppConstants.defaultBorderRadius,
                    label: 'Buy Now',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            // Related Products Section
            Text(
              'Related Products',
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 290,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: getRelatedProducts().length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final relatedProduct = getRelatedProducts()[index];
                  return ProductCard(
                    product: relatedProduct,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ProductDetailPage(product: relatedProduct),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Methods ---

  List<Product> getRelatedProducts() {
    // Dibungkus pakai array [ ] yang benar
    final List<Product> products = [
      Product(
        id: 'related3',
        name: 'Wooden Table',
        category: 'Tables',
        price: 200.00,
        imageUrl: 'assets/images/3.png',
        images: ['assets/images/3.png', 'assets/images/3.png'],
        description: 'A strong wooden table suitable for dining or work.',
        colors: ['#A0522D', '#CD853F', '#D2B48C'],
        isFavorite: false,
        specialOfferIds: ['offer3'],
      ),
      Product(
        id: 'related4',
        name: 'Classic Bed',
        category: 'Beds',
        price: 500.00,
        imageUrl: 'assets/images/4.png',
        images: ['assets/images/4.png', 'assets/images/4.png'],
        description: 'A classic single bed made with premium wood.',
        colors: ['#1ABC9C', '#F1C40F', '#E67E22'],
        isFavorite: false,
        specialOfferIds: ['offer4'],
      ),
    ];

    return products
        .where((product) => product.id != widget.product.id)
        .toList();
  }

  String _formatDate(DateTime date) {
    final DateTime now = DateTime.now();
    final Duration diff = now.difference(date);

    if (diff.inDays >= 365) {
      final int years = (diff.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 30) {
      final int months = (diff.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (diff.inDays >= 1) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  double _averageRating() {
    if (_reviews.isEmpty) return 0.0;
    final double sum = _reviews.fold(0.0, (double s, Review r) => s + r.rating);
    return double.parse((sum / _reviews.length).toStringAsFixed(1));
  }

  Widget buildStarRating(double rating, {double size = 20}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (rating >= index + 1) {
          return Icon(Icons.star, color: Colors.amber, size: size);
        } else if (rating > index && rating < index + 1) {
          return Icon(Icons.star_half, color: Colors.amber, size: size);
        } else {
          return Icon(Icons.star_border, color: Colors.amber, size: size);
        }
      }),
    );
  }
}
