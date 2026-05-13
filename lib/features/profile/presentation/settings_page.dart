import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notifyOrders = true;
  bool notifyPromotions = false;
  bool notifyPriceDrops = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: AppConstants.defaultPadding,
                  right: AppConstants.defaultPadding,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle('Notifications'),
                    _CardContainer(
                      children: [
                        _SwitchTile(
                          icon: Icons.local_shipping_outlined,
                          label: 'Order updates',
                          subtitle: 'Get notified about your order status',
                          value: notifyOrders,
                          onChanged: (value) =>
                              setState(() => notifyOrders = value),
                        ),
                        const SizedBox(height: 12),
                        Divider(height: 1, color: Colors.grey[100]),
                        const SizedBox(height: 12),
                        _SwitchTile(
                          icon: Icons.local_offer_outlined,
                          label: 'Promotions',
                          subtitle: 'Be the first to know about deals',
                          value: notifyPromotions,
                          onChanged: (value) =>
                              setState(() => notifyPromotions = value),
                        ),
                        const SizedBox(height: 12),
                        Divider(height: 1, color: Colors.grey[100]),
                        const SizedBox(height: 12),
                        _SwitchTile(
                          icon: Icons.trending_down_outlined,
                          label: 'Price Drops',
                          subtitle: 'Get alerts for items you view',
                          value: notifyPriceDrops,
                          onChanged: (value) =>
                              setState(() => notifyPriceDrops = value),
                        ),
                        const SizedBox(height: 12),
                        Divider(height: 1, color: Colors.grey[100]),
                        const SizedBox(height: 12),
                      ],
                    ),

                    const SizedBox(height: 20),
                    _SectionTitle('Legal'),

                    _CardContainer(
                      children: [
                        _NavTile(
                          icon: Icons.privacy_tip_outlined,
                          label: 'Privacy Policy',
                          onTap: () => print('Privacy Policy tapped'),
                        ),
                        const SizedBox(height: 12),
                        Divider(height: 1, color: Colors.grey[100]),
                        const SizedBox(height: 12),
                        _NavTile(
                          icon: Icons.article_outlined,
                          label: 'Terms of Service',
                          onTap: () => print('Terms of Service tapped'),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    _SectionTitle('About'),
                    _CardContainer(
                      children: [
                        _NavTile(
                          icon: Icons.privacy_tip_outlined,
                          label: 'Privacy Policy',
                          onTap: () => print('Privacy Policy tapped'),
                        ),
                        const SizedBox(height: 12),
                        Divider(height: 1, color: Colors.grey[100]),
                        const SizedBox(height: 12),
                        _NavTile(
                          icon: Icons.info_outlined,
                          label: 'About',
                          onTap: () => print('Terms of Service tapped'),
                        ),
                        Divider(height: 1, color: Colors.grey[100]),

                        _StaticTile(
                          icon: Icons.verified_outlined,
                          label: 'App Version',
                          trailing: Text(
                            '1.0.0',
                            style: GoogleFonts.outfit(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Settings',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _StaticTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;

  const _StaticTile({
    required this.icon,
    required this.label,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.black87),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black87),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                label,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.black87),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Text(
                      subtitle!,
                      style: GoogleFonts.outfit(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppConstants.primaryColor,
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final List<Widget> children;

  const _CardContainer({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
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
      child: Column(children: children),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        text,
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}