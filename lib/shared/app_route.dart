import 'package:aichatbot/responsive/web_shell.dart';
import 'package:aichatbot/screens/chat_screen.dart';
import 'package:aichatbot/screens/introduction_screen.dart';
import 'package:aichatbot/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generate(RouteSettings settings) {
    late Widget page;
   switch (settings.name) {
      case '/':
        page = const SplashScreen();
        break;

      case '/introduction':
        page = const IntroductionScreen();
        break;

       case '/ChatHomeScreen':
        page = const ChatHomeScreen();
        break;  

      default:
        page = const SplashScreen();
    }

    return MaterialPageRoute(
      builder: (_) => WebShell(child: page),
      settings: settings,
    );
  }
}
