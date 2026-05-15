import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/order/domain/entities/order.dart';
import 'package:flutter_application_1/features/order/presentation/widgets/order_card.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  final List<String> _filters = const [
    "All",
    "Processing",
    "Shipped",
    "Delivered",
    "Cancelled",
  ];

  String _selectedFilter = 'All';

  List<Order> get _orders => [
    Order(
      id: "ORD-1001",
      placedOn: DateTime.now().subtract(const Duration(days: 1)),
      status: OrderStatus.processing,
      items: const [
        'assets/images/1.png',
        'assets/images/2.png',
        'assets/images/3.png',
      ],
      totalItems: 3,
      totalAmount: 142.00,
    ),
    // // Order
    Order(
      id: "ORD-1000",
      placedOn: DateTime.now().subtract(const Duration(days: 4)),
      status: OrderStatus.shipped,
      items: const ['assets/images/4.png', 'assets/images/5.png'],
      totalItems: 2,
      totalAmount: 89.50,
    ),
    // // Order
    Order(
      id: "ORD-0999",
      placedOn: DateTime.now().subtract(const Duration(days: 12)),
      status: OrderStatus.delivered,
      items: const ['assets/images/6.png'],
      totalItems: 1,
      totalAmount: 49.99,
    ),
    // // Order
    Order(
      id: "ORD-0998",
      placedOn: DateTime.now().subtract(const Duration(days: 20)),
      status: OrderStatus.cancelled,
      items: const [
        'assets/images/1.png',
        'assets/images/2.png',
        'assets/images/3.png',
        'assets/images/4.png',
      ],
      totalItems: 4,
      totalAmount: 138.00,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Order> filtered = _selectedFilter == 'All'
        ? _orders
        : _orders
              .where((o) => _statusLabel(o.status) == _selectedFilter)
              .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHearder(context),
            const SizedBox(height: 12),
            _buildFilters(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: 8,
                ),
                itemBuilder: (_, index) => OrderCard(order: filtered[index]),
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemCount: filtered.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        itemBuilder: (_, index) {
          final String label = _filters[index];
          final bool selected = _selectedFilter == label;
          return ChoiceChip(
            label: Text(
              label,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : Colors.black87,
              ),
            ),
            selected: selected,
            onSelected: (value) => setState(() => _selectedFilter = label),
            backgroundColor: Colors.grey[100],
            selectedColor: AppConstants.primaryColor,
            showCheckmark: true,
            checkmarkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: selected ? AppConstants.primaryColor : Colors.grey[300]!,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          );
        },
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemCount: _filters.length,
      ),
    );
  }

  Widget _buildHearder(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),

          const SizedBox(width: 12),

          Text(
            'My Orders',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
