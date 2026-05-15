import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_colors.dart';
import 'package:flutter_application_1/features/admin/domain/entities/dummydata.dart';
import 'package:flutter_application_1/features/admin/domain/models/models.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/DashboardProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeBanner(),
          const SizedBox(height: 24),
          _buildKpiRow(context),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildRecentOrders(context)),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: _buildLowStockList(context)),
            ],
          ),
          const SizedBox(height: 16),
          _buildTopProducts(),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner() {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting = hour < 12
        ? 'Selamat Pagi'
        : hour < 17
        ? 'Selamat Siang'
        : 'Selamat Malam';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$greeting, Admin! 👋',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Brand Official Store — Dashboard aktif. Semua sistem berjalan normal.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _StatBadge(
                      label: 'Pesanan Baru',
                      value: '2',
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    _StatBadge(
                      label: 'Stok Kritis',
                      value: '${DummyData.lowStockCount}',
                      color: AppColors.danger,
                    ),
                    const SizedBox(width: 8),
                    _StatBadge(
                      label: 'Rating Rata-rata',
                      value: '${DummyData.avgRating.toStringAsFixed(1)} ⭐',
                      color: AppColors.warning,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.storefront_rounded, size: 80, color: Colors.white12),
        ],
      ),
    );
  }

  Widget _buildKpiRow(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxis = constraints.maxWidth > 900
            ? 4
            : constraints.maxWidth > 600
            ? 2
            : 1;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxis,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.8,
          children: [
            _KpiCard(
              title: 'Total Pendapatan',
              value: _formatCurrency(DummyData.totalRevenue),
              subtitle: '+12.5% dari bulan lalu',
              icon: Icons.account_balance_wallet_rounded,
              gradient: AppColors.primaryGradient,
              positive: true,
              // FUNGSI KLIK PINDAH HALAMAN
              onTap: () => context.read<DashboardProvider>().navigateTo(DashboardPage.financial),
            ),
            _KpiCard(
              title: 'Total Pesanan',
              value: '${DummyData.totalOrders}',
              subtitle:
                  '${DummyData.orders.where((o) => o.status == OrderStatus.pending).length} menunggu proses',
              icon: Icons.shopping_bag_rounded,
              gradient: AppColors.accentGradient,
              positive: true,
              // FUNGSI KLIK PINDAH HALAMAN
              onTap: () => context.read<DashboardProvider>().navigateTo(DashboardPage.orders),
            ),
            _KpiCard(
              title: 'Total Pelanggan',
              value: '${DummyData.totalCustomers}',
              subtitle: '+3 pelanggan baru bulan ini',
              icon: Icons.people_rounded,
              gradient: const LinearGradient(
                colors: [Color(0xFF0575E6), Color(0xFF021B79)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              positive: true,
              // FUNGSI KLIK PINDAH HALAMAN
              onTap: () => context.read<DashboardProvider>().navigateTo(DashboardPage.customers),
            ),
            _KpiCard(
              title: 'Total Produk',
              value: '${DummyData.products.length}',
              subtitle: '${DummyData.lowStockCount} produk stok kritis',
              icon: Icons.inventory_2_rounded,
              gradient: AppColors.dangerGradient,
              positive: false,
              // FUNGSI KLIK PINDAH HALAMAN
              onTap: () => context.read<DashboardProvider>().navigateTo(DashboardPage.inventory),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecentOrders(BuildContext context) {
    final orders = DummyData.orders.take(5).toList();
    return _Card(
      title: 'Pesanan Terbaru',
      action: 'Lihat Semua',
      onAction: () =>
          context.read<DashboardProvider>().navigateTo(DashboardPage.orders),
      child: Column(children: orders.map((o) => _OrderRow(order: o)).toList()),
    );
  }

  Widget _buildLowStockList(BuildContext context) {
    final low = DummyData.products.where((p) => p.isLowStock).toList();
    return _Card(
      title: 'Stok Kritis',
      action: 'Kelola',
      onAction: () =>
          context.read<DashboardProvider>().navigateTo(DashboardPage.inventory),
      child: Column(
        children: low.map((p) => _LowStockRow(product: p)).toList(),
      ),
    );
  }

  Widget _buildTopProducts() {
    final sorted = [...DummyData.products]
      ..sort((a, b) => b.stock.compareTo(a.stock));
    return _Card(
      title: 'Semua Produk — Ringkasan',
      child: Column(
        children: sorted
            .take(5)
            .map((p) => _ProductSummaryRow(product: p))
            .toList(),
      ),
    );
  }

  String _formatCurrency(double value) {
    if (value >= 1_000_000) {
      return 'Rp ${(value / 1_000_000).toStringAsFixed(1)}jt';
    }
    return 'Rp ${value.toStringAsFixed(0)}';
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _StatBadge extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatBadge({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title, value, subtitle;
  final IconData icon;
  final LinearGradient gradient;
  final bool positive;
  // TAMBAHAN: Variabel buat nangkep klik
  final VoidCallback? onTap;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.gradient,
    required this.positive,
    this.onTap, // TAMBAHAN
  });

  @override
  Widget build(BuildContext context) {
    // TAMBAHAN: Dibungkus GestureDetector biar bisa di-tap
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 18, color: Colors.white),
                ),
                const Spacer(),
                Icon(
                  positive
                      ? Icons.trending_up_rounded
                      : Icons.warning_amber_rounded,
                  size: 16,
                  color: positive ? AppColors.success : AppColors.warning,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: positive ? AppColors.success : AppColors.warning,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  final Widget child;

  const _Card({
    required this.title,
    this.action,
    this.onAction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                if (action != null)
                  GestureDetector(
                    onTap: onAction,
                    child: Text(
                      action!,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Padding(padding: const EdgeInsets.all(8), child: child),
        ],
      ),
    );
  }
}

class _OrderRow extends StatelessWidget {
  final Order order;
  const _OrderRow({required this.order});

  Color _statusColor(OrderStatus s) {
    switch (s) {
      case OrderStatus.pending:
        return AppColors.warning;
      case OrderStatus.processing:
        return AppColors.info;
      case OrderStatus.shipped:
        return AppColors.accent;
      case OrderStatus.delivered:
        return AppColors.success;
      case OrderStatus.cancelled:
        return AppColors.danger;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.id,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  order.customerName,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Rp ${(order.totalAmount / 1000).toStringAsFixed(0)}rb',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _statusColor(order.status).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              order.statusLabel,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: _statusColor(order.status),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LowStockRow extends StatelessWidget {
  final Product product;
  const _LowStockRow({required this.product});

  @override
  Widget build(BuildContext context) {
    final color = product.stock == 0 ? AppColors.danger : AppColors.warning;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              product.name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              product.stock == 0 ? 'Habis' : 'Sisa ${product.stock}',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductSummaryRow extends StatelessWidget {
  final Product product;
  const _ProductSummaryRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              size: 16,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.category,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Rp ${(product.price / 1000).toStringAsFixed(0)}rb',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 48,
            child: Text(
              'Stok: ${product.stock}',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                color: product.isLowStock
                    ? AppColors.danger
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}