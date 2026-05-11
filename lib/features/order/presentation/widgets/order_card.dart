import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/order/domain/entities/order.dart';
import 'package:flutter_application_1/features/order/presentation/widgets/items_preview.dart';
import 'package:flutter_application_1/features/order/presentation/widgets/order_detail_sheet.dart';
import 'package:flutter_application_1/features/order/presentation/widgets/status_pill.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  order.id,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ), // Expanded
              StatusPill(status: order.status),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            _formatDate(order.placedOn),
            style: GoogleFonts.outfit(color: Colors.grey[600], fontSize: 12),
          ),

          const SizedBox(height: 12),

          ItemsPreview(images: order.items),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.totalItems} items',
                      style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Total: \$${order.totalAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.outfit(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context, 
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.vertical(
                        top: Radius.circular(20),
                      )
                    ),
                    builder: (_)=> OrderDetailsSheet(
                      order: order,
                    ),
                    );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'View Detail',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
