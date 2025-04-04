import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mosqguard/pages/login/login.dart';
import 'package:mosqguard/pages/onBoardingScreens/onboarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showSecondImage = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 100, end: 200).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    Timer(const Duration(seconds: 5), () {
      _controller.forward();
      setState(() {
        _showSecondImage = true;
      });
    });

    Timer(Duration(seconds: 8), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            stops: const [0.23, 1.0],
            colors: const [
              Color(0xFF002353),
              Color(0xFF004DB9),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _animation.value,
                height: _animation.value,
                child: Image.asset("assets/mosqguard/Logo-1.png"),
              ),
              const SizedBox(height: 10),
              if (_showSecondImage)
                Image.asset(
                  "assets/mosqguard/Logo-2.png",
                  width: 150,
                  height: 150,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

