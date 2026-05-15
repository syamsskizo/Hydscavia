import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/core/common/constants/app_colors.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/DashboardProvider.dart';

class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final currentPage = provider.currentPage;
    
    // 1. Ambil status tombol tutup/buka dari mesin DashboardProvider
    final isCollapsed = provider.sidebarCollapsed; 

    return AnimatedContainer(
      // Ngasih efek animasi geser selama 200 milidetik pas ditutup/dibuka
      duration: const Duration(milliseconds: 200), 
      width: isCollapsed ? 70 : 250, // Kalau ditutup ciut jadi 70, kalau dibuka lebar 250
      height: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1)),
      ),
      child: Column(
        children: [
          // HEADER SIDEBAR / LOGO TOKO
          SizedBox(
            height: 120,
            child: Center(
              child: isCollapsed
                  ? const Icon(Icons.store, color: AppColors.primary, size: 26) // Logo mini pas ditutup
                  : const Text(
                      'BRAND STORE ADMIN',
                      style: TextStyle(
                        color: AppColors.textPrimary, 
                        fontWeight: FontWeight.bold, 
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          
          // DAFTAR MENU SIDEBAR
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.dashboard,
                  title: 'Overview',
                  page: DashboardPage.overview,
                  currentPage: currentPage,
                  isCollapsed: isCollapsed,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.list_alt,
                  title: 'Inventory',
                  page: DashboardPage.inventory,
                  currentPage: currentPage,
                  isCollapsed: isCollapsed,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.shopping_cart,
                  title: 'Orders',
                  page: DashboardPage.orders,
                  currentPage: currentPage,
                  isCollapsed: isCollapsed,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.book,
                  title: 'Blog',
                  page: DashboardPage.blog,
                  currentPage: currentPage,
                  isCollapsed: isCollapsed,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.local_offer,
                  title: 'Marketing',
                  page: DashboardPage.marketing,
                  currentPage: currentPage,
                  isCollapsed: isCollapsed,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.people,
                  title: 'Customers',
                  page: DashboardPage.customers,
                  currentPage: currentPage,
                  isCollapsed: isCollapsed,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.attach_money,
                  title: 'Financial',
                  page: DashboardPage.financial,
                  currentPage: currentPage,
                  isCollapsed: isCollapsed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required DashboardPage page,
    required DashboardPage currentPage,
    required bool isCollapsed, // Tambah parameter deteksi ciut
  }) {
    final isSelected = page == currentPage;
    
    return Tooltip(
      // Kalau lagi mengkerut, pas mouse nyorot ikon bakal muncul teks keterangannya
      message: isCollapsed ? title : '', 
      child: ListTile(
        leading: Icon(
          icon, 
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        // Kalau lagi ditutup, tulisan teks menunya dihilangkan biar gak luber keluar
        title: isCollapsed 
            ? null 
            : Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
        selected: isSelected,
        selectedTileColor: AppColors.primary.withOpacity(0.1),
        // Rumus matematika biar posisi ikon pas presisi di tengah pas layarnya ciut
        contentPadding: isCollapsed 
            ? const EdgeInsets.symmetric(horizontal: 23) 
            : const EdgeInsets.symmetric(horizontal: 16),
        onTap: () {
          context.read<DashboardProvider>().navigateTo(page);
        },
      ),
    );
  }
}