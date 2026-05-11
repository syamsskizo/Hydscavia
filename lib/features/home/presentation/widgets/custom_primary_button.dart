import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPrimaryButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String label;
  final double height;
  final double? width;
  final Color backgroundColor;
  final double borderRadius;
  final IconData? leadingIcon;
  final double iconSize;
  final Color iconColor;

  CustomPrimaryButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    this.label = 'Continue',
    this.height = 56,
    this.width,
    Color? backgroundColor,
    double? borderRadius,
    this.leadingIcon,
    this.iconSize = 20,
    this.iconColor = Colors.white,
  })  : backgroundColor = backgroundColor ?? AppConstants.primaryColor,
        borderRadius = borderRadius ?? AppConstants.defaultBorderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leadingIcon != null) ...[
                    Icon(leadingIcon, size: iconSize, color: iconColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

        