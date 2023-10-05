import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void changeScreen() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {});

    Timer.periodic(
      const Duration(seconds: 3),
      (tick) {
        Navigator.of(context).pushReplacementNamed('/');
        tick.cancel();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 3,
          ),
          Image.asset(
            "assets/image/app_logo.png",
          ),
          const Spacer(),
          const Spacer(),
          CircularProgressIndicator(
            backgroundColor: Colors.red.shade200,
          ),
          const Spacer(),
          const Text(
            "Welcome to Weather App!!",
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
