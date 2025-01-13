import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav_bar.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('پروفایل'),
      ),
      body: Center(
        child: FutureBuilder<String?>(
          future: _getUsername(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('خوش آمدید, ${snapshot.data}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.remove('username'); // حذف نام کاربری
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginForm()), // هدایت به صفحه ورود
                      );
                    },
                    child: Text('خروج'),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('لطفا وارد شوید یا ثبت نام کنید.'),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginForm()),
                      );
                    },
                    child: Text('ورود'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<String?> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ورود'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'نام کاربری'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'رمز عبور'),
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
                      MaterialPageRoute(builder: (context) => SignupForm()),
                    );
                  },
                  child: Text('ثبت نام'),
                ),
                TextButton(
                  onPressed: () {
                    // اینجا می‌توانید کارهایی که می‌خواهید انجام دهید (مثلاً هدایت به صفحه بازیابی رمز عبور) را اضافه کنید
                    print("رمز عبور را فراموش کرده‌ام");
                  },
                  child: Text('رمز عبور را فراموش کرده‌ام؟'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _signup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ثبت نام'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'نام کاربری'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'رمز عبور'),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'تکرار رمز عبور'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _signup,
                  child: Text('ثبت نام'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginForm()),
                    );
                  },
                  child: Text('ورود'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
