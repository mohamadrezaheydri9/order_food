import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset('assets/logo.png', height: 40), // آدرس لوگو خود را اینجا قرار دهید
          SizedBox(width: 10),
          Text('عنوان', style: TextStyle(fontSize: 20)), // عنوان هدر
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'جستجو...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
