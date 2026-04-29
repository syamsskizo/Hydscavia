import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/auth/presentation/pages/auth_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // simulasi login
    final bool isLoggedIn = true;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildProfileSection(),
                      const SizedBox(height: 30),
                      Expanded(child: _buildMenuSection(context, isLoggedIn)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, bool isLoggedIn) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 20),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        child: Column(
          children: [
            _buildMenuGroup('Shopping', [
              _buildMenuItem(
                icon: Icons.shopping_bag_outlined,
                title: 'My Orders',
                subtitle: 'Track your orders',
                color: Color(0xFF667eea),
                onTap: () {
                  // navigate to my order page
                },
              ),
            ]),
            const SizedBox(height: 20),
            _buildMenuGroup('Account', [
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Shipping Address',
                subtitle: 'Manage delivery addresses',
                color: Color(0xFFFF9800),
                onTap: () {
                  // navigate to Shipping addresspage
                },
              ),
              _buildMenuItem(
                icon: Icons.payment_outlined,
                title: 'Payment Methods',
                subtitle: 'Manage your payment options',
                color: Color(0xFF2196F3),
                onTap: () {
                  // navigate to paymentmethodspage
                },
              ),
            ]),
            const SizedBox(height: 20),
            _buildMenuGroup('Support', [
              _buildMenuItem(
                icon: Icons.help_outlined,
                title: 'Help Center',
                subtitle: 'Get help and support',
                color: Color(0xFF607D8B),
                onTap: () {
                  // navigate to HelpCentrescreen
                },
              ),
              _buildMenuItem(
                icon: Icons.info_outlined,
                title: 'About Us',
                subtitle: 'Learn more about our company',
                color: Color(0xFF795548),
                onTap: () {},
              ),
              _buildMenuItem(
                icon: isLoggedIn ? Icons.logout : Icons.login,
                title: isLoggedIn ? 'Sign Out' : "Sign In",
                subtitle: isLoggedIn
                    ? 'Sign Out of Your Account'
                    : "Sign In to access all features",
                color: isLoggedIn ? Color(0xFFF44336) : Color(0xFF4caf50),
                onTap: () {
                  if (isLoggedIn) {
                    // show sign out confirmation dialog
                  } else {
                    // navigate to Authpage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                    );
                  }
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // BUG FIX 1: children tadinya nggak dipanggil di dalem Container
  Widget _buildMenuGroup(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 12),
          child: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          // INI YANG HILANG SEBELUMNYA
          child: Column(
            children: children, 
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            title: Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey[600]),
            ),
            trailing: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[200]!, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(Icons.edit, color: Colors.black, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Icikiwir',
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Icikiwir@gmail.com',
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('Order', '67', Icons.shopping_bag),
              _buildStatCard('Wishlist', '69', Icons.favorite),
              _buildStatCard('Review', '12', Icons.star),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Colors.black87, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        // BUG FIX 2: Tadinya lo manggil 'value' lagi di sini
        Text(
          label, 
          style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Profile',
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              //navigate to settings page
            },
            icon: Icon(Icons.settings_outlined, color: Colors.black),
          ),
        ],
      ),
    );
  }
}