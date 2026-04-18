import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SpecialOfferWidget extends StatefulWidget {
  const SpecialOfferWidget({super.key});

  @override
  State<SpecialOfferWidget> createState() => _SpecialOfferWidgetState();
}

class _SpecialOfferWidgetState extends State<SpecialOfferWidget> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offers = List.generate(3, (index) => {
      'id': '$index',
      'title': 'Special Offer ${index + 1}', 
      'discount': 30 + index * 10,
      'description': 'Save big on modern furniture',
      'image': 'assets/images/adidas_shoe.png',
    });

    return Column(
      children: [
        SizedBox(
          height: 190, // Gue turunin jadi 190 biar sisa 20px buat indikator di bawah
          child: PageView.builder(
            controller: _pageController,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  // Vertical margin gue kecilin biar gak nambah tinggi luar
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background Gradient
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppConstants.primaryColor,
                                AppConstants.primaryColor.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        
                        // Dekorasi Lingkaran (Tetap sama)
                        Positioned(
                          right: -30, bottom: -30,
                          child: CircleAvatar(radius: 80, backgroundColor: Colors.white.withOpacity(0.1)),
                        ),

                        // Gambar Produk (Gue kecilin dikit biar gak balapan sama teks)
                        Positioned(
                          right: -30,
                          bottom: -10,
                          child: Opacity(
                            opacity: 0.85,
                            child: Image.asset(
                              offer['image'] as String,
                              height: 160, // Turun dari 200 ke 160
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        // Konten Teks & Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding dalem diciutin
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center, // Center biar seimbang
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  offer['title'] as String,
                                  style: GoogleFonts.outfit(
                                    color: AppConstants.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10, // Font kecilin
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${offer['discount']}% OFF',
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20, // Kecilin dari 24 ke 20
                                ),
                              ),
                              Text(
                                offer['description'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 12, // Kecilin dari 14 ke 12
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppConstants.primaryColor,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                  minimumSize: const Size(0, 30), // Tombol lebih slim
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Shop Now',
                                  style: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Bagian Indikator
        Padding(
          padding: const EdgeInsets.only(bottom: 8), // Jarak tipis aja
          child: SmoothPageIndicator(
            controller: _pageController,
            count: offers.length,
            effect: WormEffect(
              dotHeight: 6, // Titik lebih kecil biar estetik
              dotWidth: 6,
              spacing: 8,
              activeDotColor: AppConstants.primaryColor,
              dotColor: Colors.blueGrey.shade200,
            ),
          ), 
        )
      ],
    );
  }
}