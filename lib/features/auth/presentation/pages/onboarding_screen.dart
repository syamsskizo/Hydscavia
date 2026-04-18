import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:flutter_application_1/features/auth/presentation/pages/auth_page.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _pageController = PageController();
  int _currendPage = 0;

  final List<OnboardingPage> _page = [
      OnboardingPage(
        image: 'assets/images/onboarding_img1.png',
        title: 'Temukan Produk Unik',
        description: 'Find the perfect piece to make you home truly yours',
      ),
      OnboardingPage(
        image: 'assets/images/onboarding_img3.png',
        title: 'Quality & Comfort',
        description: 'Experience comfort with our high-quality t-shirt',
      ),
      OnboardingPage(
        image: 'assets/images/onboarding_img2.png',
        title: 'Deliveri Secepat Kilat',
        description: 'Pesanan Terikirim Dalam Waktu yang singkat',
      ),
    ];

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    void _onNextPage() {
      if (_currendPage < _page.length -1) {
        _pageController.nextPage(
          duration:const Duration(milliseconds: 500),
           curve: Curves.easeInOut,
           );
        } else {
          _completeOnboarding();
        }
    }
    
    void _completeOnboarding() {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, Animation, secondaryAnimation) => 
              const AuthPage(),
          transitionsBuilder: (context, Animation, secondaryAnimation, child) {
            return FadeTransition(opacity: Animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    } 

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Page View
          PageView.builder(
            controller: _pageController,
            itemCount: _page.length,
            onPageChanged: (index) {
              setState(() {
                _currendPage = index;
              });
            } ,
            itemBuilder: (context, index){
              return _buildPage(_page[index]);
            },
          ),
          // skip button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                'Lanjutkan',
                style: GoogleFonts.outfit(
                  color: Colors.black, 
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),

        //bottom controls
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //page indicator
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppConstants.primaryColor,
                    border: Border.all(
                      color: AppConstants.primaryColor,
                      ),
                    ),
                  child: Row(
                    children: List.generate
                      (_page.length,
                      (index)=> Container(
                        width: 8,
                        height: 8,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currendPage == index ? Colors.white : Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ),
                //next button
                ElevatedButton(
                  onPressed:_onNextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(
                        AppConstants.defaultBorderRadius,
                      )
                    )
                  ), 
                  child: Text(
                    _currendPage == _page.length - 1
                        ? 'Get Started'
                        : 'Next',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ))
              ],
            ),
          ),
        )
      ],
    ),
  );
}
  Widget _buildPage(OnboardingPage Page) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          //Image
          Image.asset(
            Page.image,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.contain,
          ),

          const Spacer(),

          //Content
          Padding(
            padding: EdgeInsets.only(bottom: 24, left: 24, right: 24),
            child: Column(
              children: [
                Text(
                  Page.title,
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                Text(
                  Page.description,
                  style: GoogleFonts.outfit(
                    color: Colors.black87,
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            ),

          const Spacer(),
        ],
      ),
    );
  }
}

class OnboardingPage{
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.description,
    required this.image,
    required this.title,
  });
}