import 'package:flutter/material.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Your AI Assistant',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                    'Using this software, you can\n ask questions and receive\n articles using artificial\n intelligent assistant  ',
                  ),
                  SizedBox(height: 50),
                  Image.asset(
                    'assets/images/introduction.png',
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/ChatHomeScreen',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: Size(300, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(width: 10),
                        Text(
                          'Get Started',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                    SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
