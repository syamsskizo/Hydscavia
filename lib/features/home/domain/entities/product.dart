  class Review {
    final String username;
    final double rating; 
    final String comment;
    final DateTime createdAt;

  Review({
    required this.username,
    required this.rating,
    required this.comment,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

  class Product {
    final String id;
    final String name;
    final String category;
    final double price;
    final String imageUrl;
    final List<String> images;
    final String description;
   final List<String> colors;
    bool isFavorite;
    final List<String> specialOfferIds;
    final List<Review> reviews;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.images,
    required this.description,
    required this.colors,
    this.isFavorite = false,
    this.specialOfferIds = const [],
    this.reviews = const [],
  });

  double getDiscountedPrice(double discountPercentage) {
    return price - (price * discountPercentage / 100);
  }

  bool get hasSpecialOffer => specialOfferIds.isNotEmpty;

  // PERBAIKAN RATING:
  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    
    double totalRating = reviews.fold(0, (sum, item) => sum + item.rating);
    
    double avg = totalRating / reviews.length;
    return double.parse(avg.toStringAsFixed(1));
  }
}