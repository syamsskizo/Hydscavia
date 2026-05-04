import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/domain/entities/product.dart';
import 'package:flutter_nestjs_tutorial_project/features/home/domain/entities/product.dart';'

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
      duration: const Duration(milliseconds: 600),
    );

    _contentAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
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

  // get all images including imageUrl and images list
  List<String> get _allImages {
    final Set<String> imageSet = <String>{};

    // add main imageUrl
    if (widget.product.imageUrl.isNotEmpty) {
      imageSet.add(widget.product.imageUrl);
    }

    // add images list
    for (final String image in widget.product.images) {
      if (image.isNotEmpty) {
        imageSet.add(image);
      }
    }

    // fallback
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
                            // TODO: full screen viewer
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
               // Back and wishlist buttons 
                // indicator dots
                Positioned(
                  top: topPadding + 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    //  List.generate(
                      _allImages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentImageIndex == index ? 10 : 6,
                        height: _currentImageIndex == index ? 10 : 6,
                        decoration: BoxDecoration(
                          color: _currentImageIndex == index
                              ? Colors.black
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // contoh content pakai animasi
          FadeTransition(
            opacity: _contentAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}