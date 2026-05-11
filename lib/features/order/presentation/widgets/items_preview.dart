import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemsPreview extends StatelessWidget {
  final List<String> images;

  const ItemsPreview({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < images.length && i < 3; i++)
          Padding(
            padding: EdgeInsets.only(right: i == (images.length - 1) ? 0 : 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[100],
                width: 54,
                height: 54,
                child: Image.asset(images[i], fit: BoxFit.cover),
              ),
            ),
          ),

        if (images.length > 3)
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '+${images.length - 3}',
              style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}
