// ─── PRODUCT MODEL ───────────────────────────────────────────────────────────
class Product {
  final String id;
  String name;
  String category;
  double price;
  double? originalPrice; // Harga Coret
  int stock;
  String imageUrl;
  String description;
  bool isActive;
  DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.stock,
    required this.imageUrl,
    required this.description,
    this.isActive = true,
    required this.createdAt,
  });

  bool get isLowStock => stock < 5;
  bool get hasDiscount => originalPrice != null && originalPrice! > price;
  double get discountPercent =>
      hasDiscount ? ((originalPrice! - price) / originalPrice! * 100) : 0;
}

// ─── ORDER MODEL ─────────────────────────────────────────────────────────────
enum OrderStatus { pending, processing, shipped, delivered, cancelled }

class OrderItem {
  final String productId;
  final String productName;
  final int qty;
  final double price;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.qty,
    required this.price,
  });

  double get subtotal => qty * price;
}

class Order {
  final String id;
  final String customerId;
  final String customerName;
  final List<OrderItem> items;
  OrderStatus status;
  String? trackingNumber;
  String? courier;
  double totalAmount;
  DateTime createdAt;
  DateTime? updatedAt;
  String shippingAddress;

  Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.items,
    required this.status,
    this.trackingNumber,
    this.courier,
    required this.totalAmount,
    required this.createdAt,
    this.updatedAt,
    required this.shippingAddress,
  });

  String get statusLabel {
    switch (status) {
      case OrderStatus.pending:
        return 'Menunggu';
      case OrderStatus.processing:
        return 'Diproses';
      case OrderStatus.shipped:
        return 'Dikirim';
      case OrderStatus.delivered:
        return 'Terkirim';
      case OrderStatus.cancelled:
        return 'Dibatalkan';
    }
  }
}

// ─── CUSTOMER MODEL ──────────────────────────────────────────────────────────
class Customer {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String city;
  final int totalOrders;
  final double totalSpent;
  final DateTime joinedAt;
  final String avatarInitials;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.totalOrders,
    required this.totalSpent,
    required this.joinedAt,
    required this.avatarInitials,
  });
}

// ─── REVIEW MODEL ────────────────────────────────────────────────────────────
class Review {
  final String id;
  final String customerId;
  final String customerName;
  final String productId;
  final String productName;
  final int rating; // 1–5
  final String comment;
  final DateTime createdAt;
  bool isReplied;

  Review({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.productId,
    required this.productName,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.isReplied = false,
  });
}

// ─── BLOG MODEL ──────────────────────────────────────────────────────────────
enum BlogStatus { draft, published }

class BlogPost {
  final String id;
  String title;
  String content;
  String author;
  String category;
  String? thumbnailUrl;
  BlogStatus status;
  DateTime createdAt;
  DateTime? publishedAt;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    this.thumbnailUrl,
    required this.status,
    required this.createdAt,
    this.publishedAt,
  });
}

// ─── VOUCHER MODEL ───────────────────────────────────────────────────────────
enum DiscountType { percentage, fixed }

class Voucher {
  final String id;
  String code;
  String description;
  DiscountType type;
  double value;
  double? minPurchase;
  int usageLimit;
  int usedCount;
  DateTime expiryDate;
  bool isActive;

  Voucher({
    required this.id,
    required this.code,
    required this.description,
    required this.type,
    required this.value,
    this.minPurchase,
    required this.usageLimit,
    required this.usedCount,
    required this.expiryDate,
    this.isActive = true,
  });

  bool get isExpired => DateTime.now().isAfter(expiryDate);
}

// ─── NOTIFICATION MODEL ───────────────────────────────────────────────────────
enum NotificationType { newOrder, lowStock, complaint, review }

class AppNotification {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime createdAt;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });
}

// ─── FINANCIAL SUMMARY MODEL ──────────────────────────────────────────────────
class MonthlySales {
  final String month;
  final double revenue;
  final int orders;

  MonthlySales({
    required this.month,
    required this.revenue,
    required this.orders,
  });
}
