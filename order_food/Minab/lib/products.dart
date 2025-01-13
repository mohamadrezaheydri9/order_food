import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'cart.dart';

class Products extends StatelessWidget {
  final List<Product> products = [
    Product('فلافل', 'assets/product/felafel2.png', 30.0),
    Product('بندری', 'assets/product/bardari.png', 40.0),
    Product('برگر مخصوص', 'assets/product/bergermakhsoos.png', 85.0),
    Product('برگر ویژه', 'assets/product/bergervizheh.png', 100.0),
    Product('چیزبرگر دوبل', 'assets/product/chiz2berger.png', 175.0),
    Product('چییز برگر', 'assets/product/chizberger.png', 90.0),
    Product('ساندویچ هات داگ', 'assets/product/hotdog.png', 80.0),
    Product('هات داگ رویال', 'assets/product/hotdogroyal.png', 100.0),
    Product('میکس برگر', 'assets/product/mixberger.png', 80.0),
    Product('اب', 'assets/product/AB2.png', 6.0),
    Product('عدس پلو', 'assets/product/adas.png', 70.0),
    Product('چلو قیمه', 'assets/product/CHELOOGHEYME.png', 95.0),
    Product('چلو قرمه سبزی', 'assets/product/CHELOOGORMEHSABZI.png', 95.0),
    Product('چلو جوجه کباب', 'assets/product/CHELOOJOJEH.png', 110.0),
    Product('چلو کوبیده', 'assets/product/CHELOOKOOBIDEH.png', 110.0),
    Product('کوکاکولا', 'assets/product/COCA.png', 30.0),
    Product('دوغ', 'assets/product/dough.png',30.0),
    Product('فانتا', 'assets/product/FANTA.png', 30.0),
    Product('اسپرایت', 'assets/product/SPRAIT.png', 30.0),
    Product('زرشک پلو', 'assets/product/ZERESHKPOLO.png', 110.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('محصولات', style: TextStyle(fontFamily: 'Yekan')),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return buildProductCard(products[index], context);
        },
      ),
    );
  }

  Widget buildProductCard(Product product, BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            product.imageUrl,
            height: 100,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Yekan'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'تومان ${product.price.toStringAsFixed(3)}',
              style: TextStyle(color: Colors.green, fontFamily: 'Yekan'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                addToCart(product, context);
              },
              child: Text('افزودن به سبد خرید', style: TextStyle(fontFamily: 'Yekan')),
            ),
          ),
        ],
      ),
    );
  }

  void addToCart(Product product, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList('cart') ?? [];

    bool productExists = cart.any((item) {
      Map<String, dynamic> decodedItem = json.decode(item);
      return decodedItem['name'] == product.name;
    });

    if (!productExists) {
      cart.add(json.encode({'name': product.name, 'price': product.price, 'imageUrl': product.imageUrl}));
      await prefs.setStringList('cart', cart);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${product.name} به سبد خرید اضافه شد!', style: TextStyle(fontFamily: 'Yekan')),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${product.name} قبلاً به سبد خرید اضافه شده است!', style: TextStyle(fontFamily: 'Yekan')),
      ));
    }
  }
}

class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product(this.name, this.imageUrl, this.price);
}
