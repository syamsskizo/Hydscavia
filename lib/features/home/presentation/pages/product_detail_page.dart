import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_nestjs_tutorial_project/features/home/domain/entities/product.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _contentAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Get all images including imageUrl and images list
  List<String> get _allImages {
    final Set<String> imageSet = <String>{};

    // Add the main imageurl first
    if (widget.product.imageUrl.isNotEmpty) {
      imageSet.add(widget.product.imageUrl);
    }

    // Add all images from the images list
    for (final String image in widget.product.images) {
      if (image.isNotEmpty) {
        imageSet.add(image);
      }
    }

    // Ensure we have at least one image (fallback to imageUrl if images list is empty)
    if (imageSet.isEmpty && widget.product.imageUrl.isNotEmpty) {
      imageSet.add(widget.product.imageUrl);
    }

    return imageSet.toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = screenHeight * 0.45;
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Product Images PageView
          SizedBox(
            height: imageHeight + topPadding,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: 'product_${widget.product.id}',
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                      itemCount: _allImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // navigate to full screen image viewer
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreenImageViewer(
                                  images: _allImages,
                                  initialIndex: index,
                                ),
                              ),
                            ); 
                          },
                          child: Container(
                            color: Colors.grey[100],
                            child: Image.asset(
                              _allImages[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // back and wishlist buttons
                Positioned(
                  top: topPadding + 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleButton(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                      ),
                      _buildCircularButton(
                        icon: icons.favorite_border,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                // page indicators (only show if there are multiple images)
                if (_allImages.length > 1)
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _allImages.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? AppConstants.primaryColor
                                : Colors.grey(300),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
                 // details section
          Expanded(
            child: ProductDetails(
              product: widget.product,
              contentAnimation: _contentAnimation,
            ),// ProductDetails
          ),
        ],
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: iconColor),
      ),
    );
  }
}