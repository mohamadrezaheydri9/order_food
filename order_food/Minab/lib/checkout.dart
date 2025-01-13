import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import the Dio package

class Checkout extends StatelessWidget {
  final double totalPrice;

  Checkout({required this.totalPrice});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نهایی کردن سفارش', style: TextStyle(fontFamily: 'Vazir')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(nameController, 'نام'),
            SizedBox(height: 16),
            _buildTextField(lastNameController, 'نام خانوادگی'),
            SizedBox(height: 16),
            _buildTextField(addressController, 'آدرس'),
            SizedBox(height: 16),
            _buildTextField(postalCodeController, 'کد پستی', keyboardType: TextInputType.number),
            SizedBox(height: 16),
            _buildTextField(phoneController, 'شماره تلفن', keyboardType: TextInputType.phone),
            SizedBox(height: 20),
            Text('مجموع: تومان ${totalPrice.toStringAsFixed(3)}', style: TextStyle(fontSize: 20, fontFamily: 'Vazir')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_areFieldsFilled()) {
                  try {
                    await _saveOrder();
                    await _sendOrderToServer(); // Send order to server
                    _showSuccessDialog(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('سفارش ثبت شد', style: TextStyle(fontFamily: 'Vazir'))),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('لطفا تمامی فیلدها را پر کنید', style: TextStyle(fontFamily: 'Vazir'))),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text('پرداخت', style: TextStyle(fontFamily: 'Vazir')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      style: TextStyle(fontFamily: 'Vazir'),
    );
  }

  bool _areFieldsFilled() {
    return nameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        postalCodeController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  Future<void> _saveOrder() async {
    Map<String, dynamic> order = {
      'name': nameController.text,
      'last_name': lastNameController.text,
      'address': addressController.text,
      'phone': phoneController.text,
      'postal_code': postalCodeController.text,
    };

  }

  Future<void> _sendOrderToServer() async {
    Dio dio = Dio();
    String url = 'https://example.com/api/orders'; // Replace with your server URL
    Map<String, dynamic> orderData = {
      'name': nameController.text,
      'last_name': lastNameController.text,
      'address': addressController.text,
      'phone': phoneController.text,
      'postal_code': postalCodeController.text,
      'total_price': totalPrice,
    };

    try {
      Response response = await dio.post(url, data: orderData);
      if (response.statusCode == 200) {
        print('Order sent successfully: ${response.data}');
      } else {
        throw Exception('Failed to send order: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to send order: $e');
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('سفارش با موفقیت ثبت شد', style: TextStyle(fontFamily: 'Vazir')),
          actions: [
            TextButton(
              child: Text('باشه', style: TextStyle(fontFamily: 'Vazir')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
