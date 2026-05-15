import 'package:flutter/material.dart';

class CardModel {
  final String brand;
  final String nameOnCard;
  final String last4;
  final String expiry;
  final bool isDefault;
  final Color brandColor;

  const CardModel({
    required this.brand,
    required this.nameOnCard,
    required this.last4,
    required this.expiry,
    required this.isDefault,
    required this.brandColor,
  });

  CardModel copyWith({
    String? brand,
    String? nameOnCard,
    String? last4,
    String? expiry,
    bool? isDefault,
    Color? brandColor,
  }) => CardModel(
    brand: brand ?? this.brand,
    nameOnCard: nameOnCard ?? this.nameOnCard,
    last4: last4 ?? this.last4,
    expiry: expiry ?? this.expiry,
    isDefault: isDefault ?? this.isDefault,
    brandColor: brandColor ?? this.brandColor,
  );
}