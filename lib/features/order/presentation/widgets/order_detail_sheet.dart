import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/order/domain/entities/order.dart';
import 'package:flutter_application_1/features/order/presentation/widgets/status_pill.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsSheet extends StatelessWidget {
  final Order order;

  const OrderDetailsSheet({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ), // EdgeInsets.only
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
              top: 12,
              bottom: 16,
            ), // EdgeInsets.only
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Order ${order.id}',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.black54,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      _formatDate(order.placedOn),
                      style: GoogleFonts.outfit(color: Colors.black87),
                    ),

                    const SizedBox(width: 12),

                    StatusPill(status: order.status),
                  ],
                ),

                Divider(color: Colors.grey[200]),
                const SizedBox(height: 12),

                Text(
                  'Items',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  height: 88,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final String imagePath = order.items[index];

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 88,
                          height: 88,
                          color: Colors.grey[100],
                          child: Image.asset(imagePath, fit: BoxFit.cover),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemCount: order.items.length,
                  ),
                ),

                const SizedBox(height: 16),

                Divider(color: Colors.grey[200]),
                const SizedBox(height: 12),

                _DetailRow(label: 'Total items', value: '${order.totalItems}'),

                const SizedBox(height: 8),

                _DetailRow(
                  label: 'Total amount',
                  value: order.totalAmount.toStringAsFixed(2),
                  isEmphasized: true,
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmphasized;

  const _DetailRow({
    required this.label,
    required this.value,
    this.isEmphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = GoogleFonts.outfit(fontWeight: FontWeight.w600);
    final TextStyle valueStyle = isEmphasized
        ? GoogleFonts.outfit(fontWeight: FontWeight.w700)
        : GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          );

    return Row(
      children: [
        Expanded(
          child: Text(label, style: baseStyle.copyWith(color: Colors.black54)),
        ), // Expanded

        Text(value, style: valueStyle),
      ],
    ); // Row
  }
}
