import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_colors.dart';
import 'package:flutter_application_1/features/admin/domain/models/models.dart';
import 'package:flutter_application_1/features/admin/presentation/pages/DashboardProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MarketingScreen extends StatelessWidget {
  const MarketingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _buildStatsCard()),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => _showVoucherDialog(context, null),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: Text(
                  'Buat Voucher',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Daftar Voucher & Promo',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: _buildVoucherList(context)),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Consumer<MarketingProvider>(
      builder: (ctx, provider, _) {
        final active = provider.vouchers
            .where((v) => v.isActive && !v.isExpired)
            .length;
        final expired = provider.vouchers.where((v) => v.isExpired).length;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              _StatItem(
                label: 'Total Voucher',
                value: '${provider.vouchers.length}',
                color: AppColors.primary,
              ),
              _divider(),
              _StatItem(
                label: 'Aktif',
                value: '$active',
                color: AppColors.success,
              ),
              _divider(),
              _StatItem(
                label: 'Kadaluarsa',
                value: '$expired',
                color: AppColors.danger,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _divider() => Container(
    width: 1,
    height: 36,
    margin: const EdgeInsets.symmetric(horizontal: 16),
    color: AppColors.border,
  );

  Widget _buildVoucherList(BuildContext context) {
    return Consumer<MarketingProvider>(
      builder: (ctx, provider, _) {
        return ListView.separated(
          itemCount: provider.vouchers.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (ctx, i) => _VoucherCard(
            voucher: provider.vouchers[i],
            provider: provider,
            onEdit: () => _showVoucherDialog(context, provider.vouchers[i]),
          ),
        );
      },
    );
  }

  void _showVoucherDialog(BuildContext context, Voucher? voucher) {
    showDialog(
      context: context,
      builder: (ctx) => _VoucherDialog(voucher: voucher),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _VoucherCard extends StatelessWidget {
  final Voucher voucher;
  final MarketingProvider provider;
  final VoidCallback onEdit;

  const _VoucherCard({
    required this.voucher,
    required this.provider,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final isExpired = voucher.isExpired;
    final progress = voucher.usageLimit > 0
        ? (voucher.usedCount / voucher.usageLimit).clamp(0.0, 1.0)
        : 0.0;
    final statusColor = isExpired
        ? AppColors.textMuted
        : voucher.isActive
        ? AppColors.success
        : AppColors.warning;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Voucher Icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: voucher.type == DiscountType.percentage
                    ? AppColors.primaryGradient
                    : AppColors.accentGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  voucher.type == DiscountType.percentage
                      ? '${voucher.value.toStringAsFixed(0)}%'
                      : '${(voucher.value / 1000).toStringAsFixed(0)}K',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        voucher.code,
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isExpired
                              ? 'Kadaluarsa'
                              : voucher.isActive
                              ? 'Aktif'
                              : 'Nonaktif',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    voucher.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Penggunaan: ${voucher.usedCount}/${voucher.usageLimit}',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                Text(
                                  '${(progress * 100).toStringAsFixed(0)}%',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: progress,
                                backgroundColor: AppColors.surfaceElevated,
                                color: progress >= 1.0
                                    ? AppColors.danger
                                    : AppColors.primary,
                                minHeight: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Actions
            Column(
              children: [
                Switch(
                  value: voucher.isActive && !isExpired,
                  onChanged: isExpired
                      ? null
                      : (_) => provider.toggleVoucher(voucher.id),
                  activeThumbColor: AppColors.primary,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: AppColors.danger,
                  ),
                  onPressed: () => provider.deleteVoucher(voucher.id),
                  tooltip: 'Hapus',
                  splashRadius: 18,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Voucher Dialog ───────────────────────────────────────────────────────────
class _VoucherDialog extends StatefulWidget {
  final Voucher? voucher;
  const _VoucherDialog({this.voucher});

  @override
  State<_VoucherDialog> createState() => _VoucherDialogState();
}

class _VoucherDialogState extends State<_VoucherDialog> {
  late TextEditingController _code, _desc, _value, _minPurchase, _limit;
  DiscountType _type = DiscountType.percentage;
  DateTime _expiry = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    _code = TextEditingController(text: widget.voucher?.code ?? '');
    _desc = TextEditingController(text: widget.voucher?.description ?? '');
    _value = TextEditingController(
      text: widget.voucher?.value.toStringAsFixed(0) ?? '',
    );
    _minPurchase = TextEditingController(
      text: widget.voucher?.minPurchase?.toStringAsFixed(0) ?? '',
    );
    _limit = TextEditingController(
      text: widget.voucher?.usageLimit.toString() ?? '100',
    );
    if (widget.voucher != null) {
      _type = widget.voucher!.type;
      _expiry = widget.voucher!.expiryDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: Text(
        widget.voucher != null ? 'Edit Voucher' : 'Buat Voucher Baru',
        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _field('Kode Voucher', _code, hint: 'Contoh: HEMAT50K'),
              const SizedBox(height: 12),
              _field('Deskripsi', _desc),
              const SizedBox(height: 12),
              // Type selector
              Row(
                children: [
                  Text(
                    'Tipe Diskon:',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ChoiceChip(
                    label: Text(
                      'Persentase (%)',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12),
                    ),
                    selected: _type == DiscountType.percentage,
                    onSelected: (_) =>
                        setState(() => _type = DiscountType.percentage),
                    selectedColor: AppColors.primary.withOpacity(0.2),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text(
                      'Nominal (Rp)',
                      style: GoogleFonts.plusJakartaSans(fontSize: 12),
                    ),
                    selected: _type == DiscountType.fixed,
                    onSelected: (_) =>
                        setState(() => _type = DiscountType.fixed),
                    selectedColor: AppColors.primary.withOpacity(0.2),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _field(
                      'Nilai Diskon',
                      _value,
                      isNumber: true,
                      hint: _type == DiscountType.percentage
                          ? 'Contoh: 20'
                          : 'Contoh: 50000',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _field(
                      'Min. Belanja (Rp)',
                      _minPurchase,
                      isNumber: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _field('Batas Penggunaan', _limit, isNumber: true),
              const SizedBox(height: 12),
              // Expiry date
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _expiry,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                    builder: (ctx, child) => Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: AppColors.primary,
                        ),
                      ),
                      child: child!,
                    ),
                  );
                  if (picked != null) setState(() => _expiry = picked);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Kadaluarsa: ${_expiry.day}/${_expiry.month}/${_expiry.year}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Batal',
            style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text(
            'Simpan',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _field(
    String label,
    TextEditingController ctrl, {
    bool isNumber = false,
    String? hint,
  }) {
    return TextField(
      controller: ctrl,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }

  void _save() {
    if (_code.text.trim().isEmpty) return;
    final newVoucher = Voucher(
      id: widget.voucher?.id ?? 'VCH-${DateTime.now().millisecondsSinceEpoch}',
      code: _code.text.trim().toUpperCase(),
      description: _desc.text,
      type: _type,
      value: double.tryParse(_value.text) ?? 0,
      minPurchase: _minPurchase.text.isNotEmpty
          ? double.tryParse(_minPurchase.text)
          : null,
      usageLimit: int.tryParse(_limit.text) ?? 100,
      usedCount: widget.voucher?.usedCount ?? 0,
      expiryDate: _expiry,
    );
    context.read<MarketingProvider>().addVoucher(newVoucher);
    Navigator.pop(context);
  }
}
