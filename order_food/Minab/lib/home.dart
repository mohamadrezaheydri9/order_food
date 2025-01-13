import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'cart.dart'; // اطمینان حاصل کنید که این فایل وجود دارد

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Product> fastFoodProducts = [
    Product('فلافل', 'assets/product/felafel2.png', 30.0),
    Product('بندری', 'assets/product/bardari.png', 40.0),
    Product('برگر مخصوص', 'assets/product/bergermakhsoos.png', 85.0),
    Product('برگر ویژه', 'assets/product/bergervizheh.png', 100.0),
    Product('چیزبرگر دوبل', 'assets/product/chiz2berger.png', 175.0),
    Product('چییز برگر', 'assets/product/chizberger.png', 90.0),
    Product('ساندویچ هات داگ', 'assets/product/hotdog.png', 80.0),
    Product('هات داگ رویال', 'assets/product/hotdogroyal.png', 100.0),
    Product('میکس برگر', 'assets/product/mixberger.png', 80.0),
    Product('رویال برگر', 'assets/product/royalberger.png', 95.0),
  ];

  final List<Product> restaurantProducts = [
    Product('چلو قیمه', 'assets/product/CHELOOGHEYME.png', 95.0),
    Product('چلو قرمه سبزی', 'assets/product/CHELOOGORMEHSABZI.png', 95.0),
    Product('چلو جوجه کباب', 'assets/product/CHELOOJOJEH.png', 110.0),
    Product('چلو کوبیده', 'assets/product/CHELOOKOOBIDEH.png', 110.0),
    Product('زرشک پلو', 'assets/product/ZERESHKPOLO.png', 110.0),
    Product('عدس پلو', 'assets/product/adas.png', 70.0),
  ];

  final List<Product> drinksProducts = [
    Product('آب', 'assets/product/AB2.png', 6.0),
    Product('کوکاکولا', 'assets/product/COCA.png', 30.0),
    Product('فانتا', 'assets/product/FANTA.png', 30.0),
    Product('اسپرایت', 'assets/product/SPRAIT.png', 30.0),
    Product('دوغ', 'assets/product/dough.png', 30.0),
  ];

  PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _currentPage++;
    } else {
      _currentPage = 0;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {});
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _currentPage--;
    } else {
      _currentPage = 2;
    }
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'yekan', // اینجا فونت Vzair را به عنوان فونت پیش‌فرض تعیین می‌کنید
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('خانه'),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildSlider(),
              SizedBox(height: 20),
              buildProductSection('ساندویچ', fastFoodProducts),
              SizedBox(height: 20),
              buildProductSection('رستوران', restaurantProducts),
              SizedBox(height: 20),
              buildProductSection('نوشیدنی', drinksProducts),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSlider() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 200,
          child: PageView(
            controller: _pageController,
            children: [
              Image.asset('assets/baner1.png', fit: BoxFit.cover),
              Image.asset('assets/combo1.png', fit: BoxFit.cover),
              Image.asset('assets/burger1.png', fit: BoxFit.cover),
            ],
          ),
        ),
        Positioned(
          left: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: _previousPage,
          ),
        ),
        Positioned(
          right: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_forward, color: Colors.white),
            onPressed: _nextPage,
          ),
        ),
      ],
    );
  }

  Widget buildProductSection(String title, List<Product> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Container(
          height: 220, // افزایش ارتفاع کانتینر
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return buildProductCard(products[index], context);
            },
          ),
        ),
      ],
    );
  }

  Widget buildProductCard(Product product, BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        width: 150,
        height: 230, // افزایش ارتفاع کارت
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('تومان ${product.price.toStringAsFixed(3)}', style: TextStyle(color: Colors.green)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), // افزایش فضای padding
              child: Container(
                height: 30, // افزایش ارتفاع دکمه
                child: ElevatedButton(
                  onPressed: () {
                    addToCart(product, context);
                  },
                  child: Text(
                      'افزودن به سبد خرید',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
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
        content: Text('${product.name} به سبد خرید اضافه شد!'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${product.name} قبلاً به سبد خرید اضافه شده است!'),
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
