import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/order/domain/entities/order.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusPill extends StatelessWidget {
  final OrderStatus status;

  const StatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final PillStyle style = _pillStyle(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: style.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        style.label,
        style: GoogleFonts.outfit(
          color: style.fg,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  PillStyle _pillStyle(OrderStatus status) {
    switch (status) {
      case OrderStatus.processing:
        return PillStyle(
          label: 'Processing',
          bg: Color(0xFFF3F2FD),
          fg: Color(0xFF1565C0),
        );

      case OrderStatus.shipped:
        return PillStyle(
          label: 'Shipped',
          bg: Color(0xFFE8F5E9),
          fg: Color(0xFF2E7D32),
        );
      case OrderStatus.delivered:
        return PillStyle(
          label: 'Delivered',
          bg: Color(0xFFFFF3E0),
          fg: Color(0xFFF57C00),
        ); // PillStyle

      case OrderStatus.cancelled:
        return PillStyle(
          label: 'Cancelled',
          bg: Color(0xFFFFEBEE),
          fg: Color(0xFFC62828),
        ); // PillStyle
    }
  }
}

class PillStyle {
  final String label;
  final Color bg;
  final Color fg;

  PillStyle({required this.label, required this.bg, required this.fg});
}
