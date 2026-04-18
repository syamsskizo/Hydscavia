import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter_application_1/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:flutter_application_1/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  // Single animation controller for a subtle, minimal entrance
  late AnimationController _controller;
  late Animation<double> _fadeinAnimation;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _scaleUpAnimation;

  // Replace these mock values with yout actual app state logic later
  final bool hasSeenOnboarding = false;
  final bool isLoggedin = false;

  @override
  void initState(){
    super.initState();
    //initialize a concise animation set
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _fadeinAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideUpAnimation= Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _scaleUpAnimation = Tween<double>(
      begin: 0.96,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Start animation
     _controller.forward();

    //Navigate to next screen after a short delay
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        Widget nextScreen;
        if(!hasSeenOnboarding) {
          nextScreen = const OnboardingScreen();
        } else if (!isLoggedin) {
          nextScreen = const AuthPage();
        } else {
          nextScreen = const MainScreen();
        }

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation,child: child);
                },
              transitionDuration: const Duration(milliseconds: 800),
          ), //pageRouteBuilder
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return FadeTransition(
            opacity: _fadeinAnimation,
            child: SlideTransition(
              position: _slideUpAnimation,
              child: ScaleTransition(
                scale: _scaleUpAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Minimal Logo Badge
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppConstants.primaryColor.withValues(alpha: 0.1),
                            AppConstants.primaryColor.withValues(alpha: 0.2),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          )
                        ],
                      ),
                      child: Center(
                        child: Stack( // Pakai Stack biar Icon di atas Container putih
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 84,
                              height: 84,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [ // PERBAIKAN: Kurung siku dan huruf kecil 'offset'
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: AppConstants.primaryColor,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ... (bagian atas tetap sama)

                    const SizedBox(height: 28),

                    // Brand title
                    Text(
                      'ShopEase',
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Tagline
                    Text(
                      'Icikiwiw',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                        color: Colors.black54,
                      ),
                    ),

                    // Beri jarak ekstra sebelum loading indicator
                    const SizedBox(height: 48),

                    // Loading Indicator
                    SizedBox(
                      width: 24, // Sedikit lebih kecil biasanya lebih elegan
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppConstants.primaryColor,
                        ),
                      ),
                    ),
                  ], // Tutup Column
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
}