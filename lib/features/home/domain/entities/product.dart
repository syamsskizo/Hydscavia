  class Review {
    final String username;
    final double rating; // Pake double biar bisa dihitung
    final String comment;
    final DateTime createdAt; // Pake DateTime lebih fleksibel

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

  // Fungsi hitung diskon (Udah oke)
  double getDiscountedPrice(double discountPercentage) {
    return price - (price * discountPercentage / 100);
  }

  bool get hasSpecialOffer => specialOfferIds.isNotEmpty;

  // PERBAIKAN RATING:
  double get averageRating {
    if (reviews.isEmpty) return 0.0;
    
    // Hitung total semua rating
    double totalRating = reviews.fold(0, (sum, item) => sum + item.rating);
    
    // Hitung rata-rata dan bulatkan 1 angka di belakang koma
    double avg = totalRating / reviews.length;
    return double.parse(avg.toStringAsFixed(1));
  }
}