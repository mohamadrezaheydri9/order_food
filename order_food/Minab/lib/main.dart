import 'package:flutter/material.dart';
import 'dart:async';
import 'bottom_nav_bar.dart'; // Import BottomNavBar widget

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amin App',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // بعد از 5 ثانیه به صفحه Home منتقل می‌شود
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavBar()), // Change to BottomNavBar
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash.png'), // آدرس عکس خود را اینجا قرار دهید
            fit: BoxFit.cover, // برای پر کردن کل صفحه
          ),
        ),

      ),
    );
  }
}
