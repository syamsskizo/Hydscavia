import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/profile/domain/entities/address.dart';
import 'package:flutter_application_1/features/profile/presentation/widgets/default_pill.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressCard extends StatelessWidget {
  final Address address;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const AddressCard({
    super.key,
    required this.address,
    required this.onSetDefault,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final Color baseBorder = Colors.grey[200]!;
    final Color cardBorder = address.isDefault
        ? AppConstants.primaryColor.withValues(alpha: 0.25)
        : baseBorder;
    final List<Color> accentColors = address.isDefault
        ? [
            AppConstants.primaryColor.withValues(alpha: 0.9),
            AppConstants.primaryColor.withValues(alpha: 0.9),
          ]
        : [Colors.grey[300]!, Colors.grey[200]!];

    return Material(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: cardBorder),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onEdit,
        splashColor: AppConstants.primaryColor.withValues(alpha: 0.08),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: accentColors,
                    ), // BoxDecoration
                  ), // Container
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    address.fullName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (address.isDefault)
                                  DefaultPill(label: 'Default'),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            tooltip: 'More',
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onSelected: (value) {
                              if (value == 'edit') onEdit();
                              if (value == 'delete') onDelete();
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit_outlined, size: 18),
                                    const SizedBox(width: 8),
                                    Text('Edit', style: GoogleFonts.outfit()),
                                  ],
                                ),
                              ),

                              PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete_outline, size: 18),
                                    const SizedBox(width: 8),
                                    Text('Delete', style: GoogleFonts.outfit()),
                                  ],
                                ),
                              ),
                            ],
                            icon: Icon(
                              Icons.more_horiz,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.call_outlined,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            address.phone,
                            style: GoogleFonts.outfit(
                              color: Colors.grey[700],
                              fontSize: 12,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _formatAddress(address),
                              style: GoogleFonts.outfit(
                                height: 1.45,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Row(
                        children: [
                          if (!address.isDefault)
                            TextButton(
                              onPressed: onSetDefault,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                backgroundColor: AppConstants.primaryColor
                                    .withValues(alpha: 0.08),
                                foregroundColor: AppConstants.primaryColor,
                                shape: StadiumBorder(),
                                minimumSize: Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star_border_rounded, size: 16),
                                  const SizedBox(width: 6),
                                  Text('Make default'),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatAddress(Address a) {
    final String line2 = a.line2.isNotEmpty ? '\n${a.line2}' : '';
    return '${a.line1}$line2\n${a.city}, ${a.state} ${a.postalCode}\n${a.country}';
  }
}
