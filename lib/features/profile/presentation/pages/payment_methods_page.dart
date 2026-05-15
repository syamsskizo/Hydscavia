import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/custom_primary_button.dart';
import 'package:flutter_application_1/features/profile/domain/entities/card_model.dart';
import 'package:flutter_application_1/features/wishlist/presentation/widgets/payment_card.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final List<CardModel> _cards = [
    CardModel(
      brand: 'Visa',
      nameOnCard: 'John Doe',
      last4: '1234',
      expiry: '12/24',
      isDefault: true,
      brandColor: const Color(0xFF1A1F71),
    ),
    CardModel(
      brand: 'Visa',
      nameOnCard: 'John Doe',
      last4: '1234',
      expiry: '12/24',
      isDefault: false,
      brandColor: const Color(0xFFFF5F00),
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
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: 12,
                ),
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return PaymentCard(
                    card: card,
                    onMakeDefault: () => _makeDefault(index),
                    onDelete: () => _delete(index),
                    onEdit: () => _edit(index),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: _cards.length,
              ),
            ),
            _buildBottomAddButton(context),
          ],
        ),
      ),
    );
  }

  void _delete(int index) {
    setState(() => _cards.removeAt(index));
  }

  void _edit(int index) => _openCardForm(existing: _cards[index], index: index);

  Widget _buildBottomAddButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.defaultPadding,
          0,
          AppConstants.defaultPadding,
          16,
        ),
        child: CustomPrimaryButton(
          isLoading: false,
          onPressed: () => _openCardForm(),
          height: 56,
          leadingIcon: Icons.add,
          label: 'Add new card',
        ),
      ),
    );
  }

  Future<void> _openCardForm({CardModel? existing, int? index}) async {
    final bool editing = index != null;

    final TextEditingController nameCtrl = TextEditingController(
      text: existing?.nameOnCard ?? '',
    );

    final TextEditingController numberCtrl = TextEditingController(
      text: existing != null ? '**** **** **** ${existing.last4}' : '',
    );

    final TextEditingController expiryCtrl = TextEditingController(
      text: existing?.expiry ?? '',
    );

    final TextEditingController brandCtrl = TextEditingController(
      text: existing?.brand ?? 'VISA',
    );

    bool isDefault = existing?.isDefault ?? _cards.isEmpty;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            top: 12,
            right: 14,
            left: 14,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          editing ? 'Edit card' : 'Add new card',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildTextField(controller: nameCtrl, label: 'Name on card'),
                  _buildTextField(
                    controller: numberCtrl,
                    label: 'Card number',
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: expiryCtrl,
                          label: 'Expiry (MM/YY)',
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          controller: brandCtrl,
                          label: 'Brand (VISA/Mastercard)',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  StatefulBuilder(
                    builder: (context, setLocalState) => Row(
                      children: [
                        Switch(
                          value: isDefault,
                          onChanged: (v) => setLocalState(() => isDefault = v),
                          activeColor: AppConstants.primaryColor,
                        ),
                        Text(
                          'Set as default',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomPrimaryButton(
                    isLoading: false,
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;

                      final String brand = brandCtrl.text.trim();
                      final Color brandColor = _inferBrandColor(brand);
                      final CardModel built = CardModel(
                        brand: brand.isEmpty ? 'VISA' : brand.toUpperCase(),
                        nameOnCard: nameCtrl.text.trim(),
                        last4: numberCtrl.text.trim().isNotEmpty
                            ? numberCtrl.text.trim().substring(
                                numberCtrl.text.trim().length - 4,
                              )
                            : '0000',
                        expiry: expiryCtrl.text.trim(),
                        isDefault: isDefault,
                        brandColor: brandColor,
                      );

                      setState(() {
                        if (index != null) {
                          _cards[index] = _cards[index].copyWith(
                            brand: built.brand,
                            nameOnCard: built.nameOnCard,
                            last4: built.last4,
                            expiry: built.expiry,
                            isDefault: built.isDefault,
                            brandColor: built.brandColor,
                          );

                          if (built.isDefault) _makeDefault(index);
                        } else {
                          if (built.isDefault) {
                            for (int i = 0; i < _cards.length; i++) {
                              _cards[i] = _cards[i].copyWith(isDefault: false);
                            }
                          }
                          _cards.add(built);
                        }
                      });

                      Navigator.pop(context);
                    },
                    height: 56,
                    label: editing ? 'Save changes' : 'Add card',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _makeDefault(int index) {
    setState(() {
      for (int i = 0; i < _cards.length; i++) {
        _cards[i] = _cards[i].copyWith(isDefault: i == index);
      }
    });
  }

  Color _inferBrandColor(String brand) {
    final String b = brand.toLowerCase();
    if (b.contains('visa')) return const Color(0xFF1A1F71);
    if (b.contains('master')) return const Color(0xFFFF5F00);
    if (b.contains('amex')) return const Color(0xFF2E77BC);
    return Colors.black87;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Required';
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
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
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Payment Methods',
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
