import 'package:flutter/foundation.dart';

class SpecialOffer {
  final String id;
  final String title;
  final String description;
  final double discountPercentage;
  final DateTime startDate;
  final DateTime endDate;
  final List<String>? applicableCategories;
  final List<String>? applicableProductIds;
  final double? minimumPurchaseAmount;
  final bool isActive;

  const SpecialOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.startDate,
    required this.endDate,
    this.applicableCategories,
    this.applicableProductIds,
    this.minimumPurchaseAmount,
    this.isActive = true,
  });

  bool isApplicableToProduct(
    String productId,
    String category,
    double price,
    List<String> productSpecialOfferIds,
  ) {
    if (!isActive) {
      debugPrint('Offer $id is not active');
      return false;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final start = DateTime(startDate.year, startDate.month, startDate.day);
    final end = DateTime(endDate.year, endDate.month, endDate.day);

    if (today.isBefore(start) || today.isAfter(end)) {
      debugPrint(
        'Offer $id is not within date range (today: $today, start: $start, end: $end)',
      );
      return false;
    }

    // Check if this product has this offer in its specialOfferIds
    final isEligible = productSpecialOfferIds.contains(id);
    debugPrint(
      'Product $productId ${isEligible ? 'has' : 'does not have'} offer $id in its specialOfferIds',
    );
    return isEligible;
  }
}
