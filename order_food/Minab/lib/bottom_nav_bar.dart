import 'package:flutter/material.dart';
import 'cart.dart';
import 'products.dart';
import 'profile.dart';
import 'home.dart'; // Import Home if it is separate

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Home(),         // Home widget added here
    Cart(),         // Your Cart widget
    Products(),     // Your Products widget
    Profile(),      // Your Profile widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex], // Expanding to fill the screen
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'خانه',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'سبد خرید',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'محصولات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'حساب کاربری',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        // اینجا ما فونت "Vazir" را به زیرنویس‌ها اضافه می‌کنیم
        selectedLabelStyle: TextStyle(fontFamily: 'Vazir'),
        unselectedLabelStyle: TextStyle(fontFamily: 'Vazir'),
      ),
    );
  }
}
