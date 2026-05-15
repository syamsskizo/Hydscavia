import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/core/common/constants/app_colors.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/DashboardProvider.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () => context.read<DashboardProvider>().toggleSidebar(),
          ),
          
          const Spacer(), // Search bar tetap kosong bersih sesuai request
          
          // NOTIFIKASI DROPDOWN
          Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: PopupMenuButton<DashboardPage>(
              tooltip: 'Notifikasi',
              color: AppColors.surfaceElevated,
              offset: const Offset(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.withOpacity(0.1)),
              ),
              icon: Stack(
                children: [
                  const Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle),
                      child: const Text(
                        '3',
                        style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              onSelected: (DashboardPage page) {
                context.read<DashboardProvider>().navigateTo(page);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<DashboardPage>>[
                PopupMenuItem<DashboardPage>(
                  value: DashboardPage.orders,
                  child: _buildNotifItem(
                    Icons.shopping_bag_rounded, AppColors.success, 
                    'Pesanan Baru!', 'ORD-2025-003 dari Sari Dewi...'
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<DashboardPage>(
                  value: DashboardPage.inventory,
                  child: _buildNotifItem(
                    Icons.warning_amber_rounded, AppColors.warning, 
                    'Stok Hampir Habis', 'Parfum Oud Arabia 100ml - sisa 2!'
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem<DashboardPage>(
                  value: DashboardPage.customers,
                  child: _buildNotifItem(
                    Icons.star_rounded, Colors.purpleAccent, 
                    'Review Baru', 'Maya Kusuma memberikan 5 bintang'
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // TOMBOL PROFIL
          GestureDetector(
            onTap: () => _showAdminProfileDialog(context),
            child: const MouseRegion(
              cursor: SystemMouseCursors.click,
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifItem(IconData icon, Color color, String title, String subtitle) {
    return SizedBox(
      width: 250,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.textSecondary, fontSize: 11
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DIALOG KARTU PROFIL ADMIN + TOMBOL LOG OUT
  void _showAdminProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceElevated,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              const CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                'Hisyam',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary
                ),
              ),
              Text(
                'ID Admin: ADM-192A37-08',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.grey, height: 1),
              const SizedBox(height: 16),
              
              _buildProfileRow('Jabatan', 'Owner / Super Admin'),
              const SizedBox(height: 12),
              _buildProfileRow('Status Sesi', 'Aktif (Lokal)', isStatus: true),
              const SizedBox(height: 8),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Batal',
                style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
              ),
            ),
            // ─── TOMBOL LOG OUT MERAH SAKTI ───
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () {
                Navigator.pop(context); // Tutup Dialog Kartu Profil
                
                // Memunculkan Bar Notifikasi di bawah layar monitor TV Abang
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.danger,
                    content: Text(
                      'Sesi login diselesaikan. Log Out Berhasil (Simulasi)!',
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              icon: const Icon(Icons.logout_rounded, size: 16),
              label: Text(
                'Log Out',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileRow(String label, String value, {bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 13),
        ),
        isStatus
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.success, fontSize: 12, fontWeight: FontWeight.bold
                  ),
                ),
              )
            : Text(
                value,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600
                ),
              ),
      ],
    );
  }
}