class Order {
  final String id;
  final DateTime placedOn;
  final OrderStatus status;
  final List<String> items;
  final int totalItems;
  final double totalAmount;

  const Order({
    required this.id,
    required this.placedOn,
    required this.status,
    required this.items,
    required this.totalItems,
    required this.totalAmount,
  });
}

enum OrderStatus {
  processing,
  shipped,
  delivered,
  cancelled,
}