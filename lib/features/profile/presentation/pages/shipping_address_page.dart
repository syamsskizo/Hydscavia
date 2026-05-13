import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/home/presentation/widgets/custom_primary_button.dart';
import 'package:flutter_application_1/features/profile/domain/entities/address.dart';
import 'package:flutter_application_1/features/profile/presentation/widgets/address_card.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressPage extends StatefulWidget {
  const ShippingAddressPage({super.key});

  @override
  State<ShippingAddressPage> createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  final List<Address> _addresses = [
    const Address(
      fullName: 'John Doe',
      phone: '+1 202 555 0174',
      line1: '123 Market Street',
      line2: 'Apt 4B',
      city: 'San Francisco',
      state: 'CA',
      postalCode: '94103',
      country: 'United States',
      isDefault: true,
    ),
    const Address(
      fullName: 'Jane Smith',
      phone: '+1 415 555 0136',
      line1: '742 Evergreen Terrace',
      line2: '',
      city: 'Springfield',
      state: 'IL',
      postalCode: '62704',
      country: 'United States',
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
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: 12,
                ),
                itemBuilder: (context, index) {
                  final Address address = _addresses[index];

                  return AddressCard(
                    address: address,
                    onSetDefault: () => _setDefult(index),
                    onDelete: () => _delete(index),
                    onEdit: () => _edit(index),
                  );
                },
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemCount: _addresses.length,
              ),
            ),

            _buildBottomAddButton(context),
          ],
        ),
      ),
    );
  }

  void _delete(int index) {
    setState(() {
      _addresses.removeAt(index);
    });
  }

  void _edit(int index) {
    _openAddressForm(existing: _addresses[index], index: index);
  }

  Widget _buildBottomAddButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(
          AppConstants.defaultPadding,
          0,
          AppConstants.defaultPadding,
          16,
        ),
        child: CustomPrimaryButton(
          isLoading: false,
          onPressed: () => _openAddressForm(),
          height: 56,
          leadingIcon: Icons.add,
          label: 'Add new address',
        ),
      ),
    );
  }

  Future<void> _openAddressForm({Address? existing, int? index}) async {
    final bool editing = index != null;

    final TextEditingController nameCtrl = TextEditingController(
      text: existing?.fullName ?? '',
    );

    final TextEditingController phoneCtrl = TextEditingController(
      text: existing?.phone ?? '',
    );

    final TextEditingController line1Ctrl = TextEditingController(
      text: existing?.line1 ?? '',
    );

    final TextEditingController line2Ctrl = TextEditingController(
      text: existing?.line2 ?? '',
    );

    final TextEditingController cityCtrl = TextEditingController(
      text: existing?.city ?? '',
    );

    final TextEditingController stateCtrl = TextEditingController(
      text: existing?.state ?? '',
    );

    final TextEditingController postalCtrl = TextEditingController(
      text: existing?.postalCode ?? '',
    );

    final TextEditingController countryCtrl = TextEditingController(
      text: existing?.country ?? '',
    );

    bool isDefault = existing?.isDefault ?? (_addresses.isEmpty);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          editing ? 'Edit address' : 'Add new address',
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  _buildTextField(controller: nameCtrl, label: 'Full Name'),
                  _buildTextField(
                    controller: phoneCtrl,
                    label: 'Phone',
                    keyboardType: TextInputType.phone,
                  ),
                  _buildTextField(
                    controller: line1Ctrl,
                    label: 'Address line 1',
                  ),
                  _buildTextField(
                    controller: line2Ctrl,
                    label: 'Address line 2 (optional)',
                    required: false,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: cityCtrl,
                          label: 'City',
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          controller: stateCtrl,
                          label: 'State/Region',
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: postalCtrl,
                          label: 'Postal code',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(
                          controller: countryCtrl,
                          label: 'Country',
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

                      final Address built = Address(
                        fullName: nameCtrl.text.trim(),
                        phone: phoneCtrl.text.trim(),
                        line1: line1Ctrl.text.trim(),
                        line2: line2Ctrl.text.trim(),
                        city: cityCtrl.text.trim(),
                        state: stateCtrl.text.trim(),
                        postalCode: postalCtrl.text.trim(),
                        country: countryCtrl.text.trim(),
                        isDefault: isDefault,
                      );

                      setState(() {
                        if (index != null) {
                          final int idx = index;
                          _addresses[idx] = _addresses[idx].copyWith(
                            fullName: built.fullName,
                            phone: built.phone,
                            line1: built.line1,
                            line2: built.line2,
                            city: built.city,
                            state: built.state,
                            postalCode: built.postalCode,
                            country: built.country,
                            isDefault: built.isDefault,
                          );

                          if (built.isDefault) {
                            _setDefult(idx);
                          }
                        } else {
                          if (built.isDefault) {
                            for (int i = 0; i < _addresses.length; i++) {
                              _addresses[i] = _addresses[i].copyWith(
                                isDefault: false,
                              );
                            }
                          }
                          _addresses.add(built);
                        }
                      });

                      Navigator.pop(context);
                    },
                    height: 56,
                    label: editing ? 'Save changes' : 'Add address',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    bool required = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (!required) return null;
          if (value == null || value.trim().isEmpty) return 'Required';
        },
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _setDefult(int index) {
    setState(() {
      for (int i = 0; i < _addresses.length; i++) {
        _addresses[i] = _addresses[i].copyWith(isDefault: i == index);
      }
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[200]!, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 14,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back_ios_new, size: 18),
            ),
          ),
          SizedBox(width: 12),

          Text(
            "Shipping Address",
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
