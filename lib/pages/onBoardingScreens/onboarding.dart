import 'package:flutter/material.dart';
import 'package:mosqguard/pages/login/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final List<String> _titles = [
    'Welcome to MosqGuard',
    'Easy Setup',
    'Stay Protected',
  ];

  final List<String> _descriptions = [
    'MosqGuard is your go-to app for protecting your device.',
    'Setup MosqGuard in a few simple steps to secure your device.',
    'We are group 13, Department of Computer Science - Batch 12.',
  ];

  final List<String> _images = [
    'assets/mosqguard/Logo-1.png',
    'assets/mosqguard/onboard1.jpg',
    'assets/mosqguard/unilogobgremove.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Full-screen content for each step
          Positioned.fill(
            child: PageView.builder(
              itemCount: _titles.length,
              itemBuilder: (context, index) {
                return _buildOnboardingStep(index);
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),

          // Circular Progress Indicator (Invisible bar)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_titles.length, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
          ),

          // Floating Action Button for next step
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                if (_currentPage < _titles.length - 1) {
                  // Move to the next page in the onboarding flow
                  setState(() {
                    _currentPage++;
                  });
                } else {
                  // After the last page, navigate to the login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                }
              },
              backgroundColor: Colors.black,
              child: Icon(
                _currentPage < _titles.length - 1
                    ? Icons.arrow_forward
                    : Icons.check,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingStep(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Main Image with Micro-Interaction
        GestureDetector(
          onTap: () {
            // Micro-interaction on tap
            setState(() {
              // Example of tapping changing the image
              _images[index] = _images[index]; // (You can change to another animation or image)
            });
          },
          child: AnimatedOpacity(
            opacity: _currentPage == index ? 1 : 0.3,
            duration: Duration(milliseconds: 500),
            child: Image.asset(
              _images[index],
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 30),

        // Title Text
        Text(
          _titles[index],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center, // Correct placement of textAlign
        ),
        SizedBox(height: 15),

        // Description Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            _descriptions[index],
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center, // Correct placement of textAlign
          ),
        ),
      ],
    );
  }
}
