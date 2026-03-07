import 'package:flutter/material.dart';
import 'package:rest/screens/login_main.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF8F6),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              _buildOnboardingPage(
                title: 'Quality',
                subtitle: 'Sell fresh products directly to consumers and reduce middlemen in supply chain',
                gradientColors: [Color(0xFF4CAF50), Color(0xFF81C784)],
                imagePath: 'assets/images/Group 44.png',
                buttonColor: Color(0xFF4CAF50),
              ),
              _buildOnboardingPage(
                title: 'Convenient',
                subtitle: 'Your orders get delivered on time and promptly to your customers',
                gradientColors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                imagePath: 'assets/images/Group.png',
                buttonColor: Color(0xFFFF9800),
              ),
              _buildOnboardingPage(
                title: 'Local',
                subtitle: 'We love our local carbon footprint to order within',
                gradientColors: [Color(0xFFFFC107), Color(0xFFFFEE58)],
                imagePath: 'assets/images/Group 46.png',
                buttonColor: Color(0xFFFFC107),
              ),
            ],
          ),

          // Dots Indicator + Buttons
          Positioned(
            bottom: 20,
            left: 32,
            right: 32,
            child: Column(
              children: [
                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: index == _currentPage ? 28 : 8,
                      decoration: BoxDecoration(
                        color: index == _currentPage ? Color(0xFFE67E5C) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 40),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: _currentPage != 2
                          ? TextButton(
                        onPressed: () => _pageController.animateToPage(
                          _currentPage - 1,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: Text(
                          'Back',
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      )
                          : Container(),
                    ),
                    SizedBox(width: _currentPage == 2 ? 16 : 0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _currentPage < 2
                            ? () => _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut)
                            : () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WelcomeScreen())),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE67E5C),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          elevation: 8,
                        ),
                        child: Text(
                          _currentPage < 2 ? 'Next' : 'Get Started',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required String imagePath,
    required Color buttonColor,
  }) {
    return Container(
      color: buttonColor,
      padding: EdgeInsets.all(22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration (use your image assets)
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 32,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColors),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Icon(
                    Icons.home, // Fallback icon
                    size: 120,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 48),

          Container(
            child: Column(
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),

                SizedBox(height: 16),

                // Subtitle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Join Movement Button (decorative)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: gradientColors),
                    borderRadius: BorderRadius.circular(32),
                    border: Border(top: BorderSide(color: Colors.white),bottom: BorderSide(color: Colors.white)),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColors.last.withOpacity(0.4),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Text(
                    'Join the movement',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
