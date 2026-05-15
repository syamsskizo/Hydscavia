import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_colors.dart';
import 'package:flutter_application_1/features/admin/domain/entities/dummydata.dart';
import 'package:flutter_application_1/features/admin/domain/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // FUNGSI SAKTI: Mengatur keselarasan warna sesuai dengan isi overview.dart
  Color _getStatusColor(OrderStatus s) {
    switch (s) {
      case OrderStatus.pending:
        return AppColors.warning;   // Oren
      case OrderStatus.processing:
        return AppColors.info;      // Biru
      case OrderStatus.shipped:
        return AppColors.accent;    // Ungu
      case OrderStatus.delivered:
        return AppColors.success;   // Ijo
      case OrderStatus.cancelled:
        return AppColors.danger;    // Merah
    }
  }

  @override
  Widget build(BuildContext context) {
    final orders = DummyData.orders;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manajemen Pesanan',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pantau transaksi, ubah status, dan lihat rincian pesanan.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                separatorBuilder: (context, index) => const Divider(color: Colors.grey, height: 20),
                itemBuilder: (context, index) {
                  final order = orders[index];

                  return Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      iconColor: AppColors.primary,
                      collapsedIconColor: AppColors.textSecondary,
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.shopping_bag_outlined, color: _getStatusColor(order.status), size: 24),
                      ),
                      title: Text(
                        order.id,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pelanggan: ${order.customerName}',
                            style: GoogleFonts.plusJakartaSans(fontSize: 12, color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 4),
                          _buildStatusBadge(order.status),
                        ],
                      ),
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.background.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // UBAH STATUS DROPDOWN
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Update Status:',
                                    style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton<OrderStatus>(
                                    value: order.status,
                                    dropdownColor: AppColors.surfaceElevated,
                                    style: GoogleFonts.plusJakartaSans(color: _getStatusColor(order.status), fontWeight: FontWeight.bold),
                                    underline: const SizedBox(),
                                    items: OrderStatus.values.map((status) {
                                      return DropdownMenuItem(
                                        value: status,
                                        child: Text(status.name.toUpperCase()),
                                      );
                                    }).toList(),
                                    onChanged: (newStatus) {
                                      if (newStatus != null) {
                                        setState(() {
                                          order.status = newStatus;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const Divider(color: Colors.grey),
                              const SizedBox(height: 8),

                              // RINCIAN BARANG
                              Text(
                                'Rincian Pembelian:',
                                style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              
                              ...List.generate(2, (i) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '- Produk Premium Official ${i + 1} (x1)',
                                      style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 13),
                                    ),
                                    Text(
                                      'Rp ${(order.totalAmount / 2).toStringAsFixed(0)}',
                                      style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              )),
                              
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'TOTAL KESELURUHAN:',
                                    style: GoogleFonts.plusJakartaSans(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Rp ${order.totalAmount.toStringAsFixed(0)}',
                                    style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(OrderStatus status) {
    final statusColor = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: statusColor,
        ),
      ),
    );
  }
}