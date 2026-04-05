import 'package:commity_app1/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const CommitySplashScreen(), //  Splash 
    );
  }
}