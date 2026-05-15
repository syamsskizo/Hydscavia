import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/core/common/constants/app_colors.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/DashboardProvider.dart';
import 'package:flutter_application_1/features/admin/presentation/widgets/sidebar.dart';

// Import komponen halaman yang sudah pasti aman:
import 'package:flutter_application_1/features/admin/presentation/pages/overview.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/inventory_screen.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/marketing.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/customer.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/financial.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/order.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/blog.dart';

// NOTE: Jika baris di bawah ini merah, klik tulisan HeaderWidget di bawah, lalu tekan Ctrl + . untuk auto-import
import 'package:flutter_application_1/features/admin/presentation/widgets/header.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = context.watch<DashboardProvider>().currentPage;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // KIRI: Sidebar yang sudah bisa mengkerut/menutup otomatis
          const SidebarWidget(),

          // KANAN: Area Konten Utama
          Expanded(
            child: Column(
              children: [
                // Header Atas (Tombol Hamburger & Lonceng Notifikasi)
                const HeaderWidget(),

                // Konten halaman tengah yang dinamis
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _buildActivePage(currentPage),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Pengatur halaman aktif di monitor TV
  Widget _buildActivePage(DashboardPage page) {
    switch (page) {
      case DashboardPage.overview:
        return const OverviewScreen();
      case DashboardPage.inventory:
        return const InventoryScreen();
      case DashboardPage.marketing:
        return const MarketingScreen();
      case DashboardPage.customers:
        return const CustomersScreen();
      case DashboardPage.financial:
        return const FinancialScreen();
      case DashboardPage.orders:
        return const OrdersScreen();
      case DashboardPage.blog:
        return const BlogScreen();
    }
  }
}