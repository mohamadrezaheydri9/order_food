import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void _signup() async {
    if (passwordController.text == confirmPasswordController.text) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', usernameController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('رمزهای عبور مطابقت ندارند')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ثبت‌نام')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'نام کاربری',
                  border: OutlineInputBorder(), // حاشیه برای فیلد
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'رمز عبور',
                  border: OutlineInputBorder(), // حاشیه برای فیلد
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'تکرار رمز عبور',
                  border: OutlineInputBorder(), // حاشیه برای فیلد
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: Text('ثبت‌نام'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
