import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Signup.dart';
import 'profile.dart';
import 'bottom_nav_bar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    final prefs = await SharedPreferences.getInstance();
    if (usernameController.text == "user" && passwordController.text == "pass") {
      await prefs.setString('username', usernameController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Profile()), // اطمینان حاصل کنید که Profile تعریف شده است
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('نام کاربری یا رمز عبور نادرست است')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ورود')),
      body: Stack( // استفاده از Stack برای قرار دادن BottomNavigationBar در بالای محتوا
        children: [
          Center( // فرم را وسط‌چین می‌کند
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2), // حاشیه
                borderRadius: BorderRadius.circular(10), // گرد کردن گوشه‌ها
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // اندازه ستون را به حداقل می‌رساند
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'نام کاربری',
                      border: OutlineInputBorder(), // حاشیه برای TextField
                    ),
                  ),
                  SizedBox(height: 10), // فاصله بین فیلدها
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'رمز عبور',
                      border: OutlineInputBorder(), // حاشیه برای TextField
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('ورود'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text('اگر حساب کاربری ندارید، ثبت‌نام کنید'),
                  ),
                ],
              ),
            ),
          ),
          Positioned( // قرار دادن BottomNavigationBar در پایین صفحه
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavBar(),
          )
        ],
      ),
    );
  }
}

