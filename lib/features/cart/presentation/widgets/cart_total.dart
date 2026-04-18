import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/cart/domain/entities/cart_item.dart';
import 'package:google_fonts/google_fonts.dart';

class CartTotal extends StatelessWidget {
  final double total;
  final List<CartItem> cartItems;

  const CartTotal({
    super.key,
    required this.total,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    // Itung pajak & total akhir biar kodenya gak numpuk di bawah
    final double shipping = 10.00;
    final double tax = total * 0.11;
    final double finalTotal = total + shipping + tax;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. RINCIAN BIAYA
            _buildSummaryRow('Subtotal', total),
            const SizedBox(height: 12),
            _buildSummaryRow('Shipping', shipping),
            const SizedBox(height: 12),
            _buildSummaryRow('Tax (PPN 11%)', tax),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(height: 1, thickness: 1.2, color: Color(0xFFF1F1F1)),
            ),

            // 2. TOTAL AKHIR
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  '\$${finalTotal.toStringAsFixed(2)}',
                  style: GoogleFonts.outfit(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // 3. TOMBOL CHECKOUT (CUSTOM BOX)
            InkWell(
              onTap: () {
                // TODO: Connect to Firebase
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: double.infinity,
                height: 65,
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppConstants.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Checkout Now',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method biar gak nulis Row berulang-ulang
  Widget _buildSummaryRow(String title, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 14, 
            color: Colors.grey[500],
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}