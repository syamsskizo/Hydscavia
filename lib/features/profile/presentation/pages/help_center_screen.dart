import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Catatan: Pastikan AppConstants sudah didefinisikan di project Anda
class AppConstants {
  static const double defaultPadding = 16.0;
}

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<_Faq> _faqs = const [
    _Faq(
      q: 'Where is my order?',
      a: 'You can track your order status from My Orders. If the expected delivery time has passed, contact support w',
    ),
    _Faq(
      q: 'How do I return an item?',
      a: 'Go to My Orders, select the order, and choose Return/Replace. Follow the steps to schedule a pickup.',
    ),
    _Faq(
      q: 'What payment methods are accepted?',
      a: 'We accept major credit/debit cards, popular wallets, and UPI where available. For details, see Payment Metho',
    ),
    _Faq(
      q: 'Can I change my delivery address?',
      a: 'Addresses can be edited from Shipping Address in Profile. For orders already placed, contact support to requ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: 16,
                ),
                children: [
                  _buildSearchCard(context),
                  const SizedBox(height: 16),
                  _buildQuickTopics(),
                  const SizedBox(height: 20),
                  Text(
                    'Frequently asked questions',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ..._faqs.map((faq) => _FaqItem(faq: faq)),
                  const SizedBox(height: 20),
                  Text(
                    'Contact us',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ContactTile(
                    icon: Icons.chat_bubble_outline_outlined,
                    title: 'Chat with us',
                    subtitle: 'Typical reply time: under 5 minutes',
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  _ContactTile(
                    icon: Icons.email_outlined,
                    title: 'Email Support',
                    subtitle: 'Support @example.com',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTopics() {
    final List<_Topic> topics = const [
      _Topic(Icons.local_shipping_outlined, 'Shipping'),
      _Topic(Icons.payment_outlined, 'Payments'),
      _Topic(Icons.assignment_return_outlined, 'Returns'),
      _Topic(Icons.security_outlined, 'Security'),
    ];
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) => _TopicChip(topic: topics[i]),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: topics.length,
      ),
    );
  }

  Widget _buildSearchCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'How can we help you?',
                hintStyle: GoogleFonts.outfit(color: Colors.grey[500]),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 14,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Help Center',
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

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.black87),
        ),
        title: Text(
          title,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.outfit(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  final _Faq faq;
  const _FaqItem({required this.faq});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.faq.q,
                        style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                      ),
                    ),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      widget.faq.a,
                      style: GoogleFonts.outfit(
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ),
                  secondChild: const SizedBox.shrink(),
                  crossFadeState: _expanded
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopicChip extends StatelessWidget {
  final _Topic topic;
  const _TopicChip({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(topic.icon, size: 18, color: Colors.black87),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              topic.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _Topic {
  final IconData icon;
  final String label;
  const _Topic(this.icon, this.label);
}

class _Faq {
  final String q;
  final String a;
  const _Faq({required this.q, required this.a});
}