import 'package:flutter_application_1/features/home/domain/entities/product.dart';

class CartItem{
  final Product product;
  int quantity;
  final String selectedColor;
  final double? discountPercentage;

  CartItem({
    required this.product,
    required this.quantity,
    required this.selectedColor,
    this.discountPercentage,
  });

  double get totalPrice {
    if (product.hasSpecialOffer && discountPercentage != null) {
      return product.getDiscountedPrice(discountPercentage!) * quantity;
    }
    return product.price * quantity;
  }

  double get unitPrice {
    if (product.hasSpecialOffer && discountPercentage !=null) {
      return product.getDiscountedPrice(discountPercentage!);
    }
    return product.price;
  }
}