import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'checkout.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  void loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];

    setState(() {
      cartItems = cart.map((item) {
        Map<String, dynamic> productMap = json.decode(item);
        return CartItem(
          product: Product(
            title: productMap['name'],
            price: productMap['price'],
            image: productMap['imageUrl'],
          ),
          quantity: productMap['quantity'] ?? 1, // مقدار پیش‌فرض به 1
        );
      }).toList();
    });
  }

  void removeProduct(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];
    cart.removeAt(index);
    await prefs.setStringList('cart', cart);

    setState(() {
      cartItems.removeAt(index);
    });
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      cartItems[index].quantity += delta;
      if (cartItems[index].quantity < 1) {
        removeProduct(index);
      } else {
        saveCart();
      }
    });
  }

  void saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = cartItems.map((item) {
      return json.encode({
        'name': item.product.title,
        'price': item.product.price,
        'imageUrl': item.product.image,
        'quantity': item.quantity,
      });
    }).toList();

    await prefs.setStringList('cart', cart);
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(0, (sum, item) => sum + (item.product.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: const Text('سبد خرید'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? Center(
              child: Text(
                'سبد خرید خالی است',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
                : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(cartItems[index].product.image),
                    title: Text(cartItems[index].product.title),
                    subtitle: Text('تومان ${cartItems[index].product.price.toStringAsFixed(3)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => updateQuantity(index, -1),
                        ),
                        Text(cartItems[index].quantity.toString()),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => updateQuantity(index, 1),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            removeProduct(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (cartItems.isNotEmpty) // Only show total price and button if cart is not empty
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('مجموع: تومان ${totalPrice.toStringAsFixed(3)}', style: const TextStyle(fontSize: 20)),
            ),
          if (cartItems.isNotEmpty) // Only show button if cart is not empty
            ElevatedButton(
              onPressed: () {
                // Navigate to checkout page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Checkout(totalPrice: totalPrice)),
                );
              },
              child: const Text('نهایی کردن سفارش'),
            ),
        ],
      ),
    );
  }
}

class Product {
  final String title;
  final double price;
  final String image;

  Product({required this.title, required this.price, required this.image});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
