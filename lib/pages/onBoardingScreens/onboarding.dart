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
    'assets/mosqguard/who-logo.png',
    'assets/mosqguard/onboard1.jpg',
    'assets/mosqguard/unilogobgremove.png',
  ];

  final List<Color> _backgroundColors = [
    Colors.black,
    Colors.white,
    Colors.deepPurple.shade900,
  ];

  final List<Color> _titleColors = [
    Colors.white,
    Colors.black,
    Colors.white,
  ];

  final List<Color> _descriptionColors = [
    Colors.white,
    Colors.black,
    Colors.white,
  ];

  final List<Color> _arrowColor = [
    Colors.black,
    Colors.white,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: _backgroundColors[_currentPage],
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                itemCount: _titles.length,
                itemBuilder: (context, index) => _buildOnboardingStep(index),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
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
                          ? Colors.white
                          : Colors.grey.shade400,
                    ),
                  );
                }),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: _currentPage == _titles.length - 1
                  ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                backgroundColor: _arrowColor[_currentPage],
                child: Icon(
                  Icons.check,
                  color: _descriptionColors[_currentPage],
                ),
              )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingStep(int index) {
    final bool isActive = _currentPage == index;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: isActive ? 1 : 0.3,
          duration: Duration(milliseconds: 500),
          child: Image.asset(
            _images[index],
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 30),
        AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _titleColors[index],
          ),
          textAlign: TextAlign.center,
          child: Text(_titles[index]),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            style: TextStyle(
              fontSize: 16,
              color: _descriptionColors[index],
            ),
            textAlign: TextAlign.center,
            child: Text(_descriptions[index]),
          ),
        ),
      ],
    );
  }
}
