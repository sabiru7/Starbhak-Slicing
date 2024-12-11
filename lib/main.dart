import 'package:flutter/material.dart';
import 'profile.dart';
import 'cart.dart';
import 'profile_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
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
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo.jpg'), // Menampilkan logo
      ),
    );
  }
}

//home
class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
       actions: [
  IconButton(
    icon: const Icon(Icons.person, color: Colors.black),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    },
  ),
],
      ),
      
      body: Column(
        children: [
          // Bagian kategori
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryItem(isSelected: true, iconPath: 'assets/burger.jpg'),
                CategoryItem(isSelected: false, iconPath: 'assets/burger.jpg'),
                CategoryItem(
                    isSelected: false, iconPath: 'assets/teh_botol.jpg'),
              ],
            ),
          ),

          // Judul dan list makanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'All Food',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                // Bagian Grid
                Expanded(
                  child: GridView.count(
                    crossAxisCount: MediaQuery.of(context).size.width > 600
                        ? 4
                        : 2, // Responsif
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 2 / 2.5,
                    padding: const EdgeInsets.all(15.0),
                    children: const [
                      FoodItem(
                        imagePath: 'assets/burger.jpg',
                        name: 'Burger King large',
                        price: 'Rp. 50.000,00',
                      ),
                      FoodItem(
                        imagePath: 'assets/burger.jpg',
                        name: 'Burger King medium',
                        price: 'Rp. 50.000,00',
                      ),
                      FoodItem(
                        imagePath: 'assets/burger.jpg',
                        name: 'Burger King small',
                        price: 'Rp. 50.000,00',
                      ),
                      FoodItem(
                        imagePath: 'assets/teh_botol.jpg',
                        name: 'Teh Botol',
                        price: 'Rp. 4.000,00',
                      ),
                      FoodItem(
                        imagePath: 'assets/cocacola.jpg',
                        name: 'Coca Cola large',
                        price: 'Rp. 8.000,00',
                      ),
                      FoodItem(
                        imagePath: 'assets/cocacola.jpg',
                        name: 'Coca Cola medium',
                        price: 'Rp. 6.000,00',
                      ),
                      FoodItem(
                        imagePath: 'assets/cocacola.jpg',
                        name: 'Coca Cola small',
                        price: 'Rp. 4.000,00',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Orders',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Cart()));
          }
          if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Pfl()));
          }
        },
      ),
    );
  }
}

// Widget untuk kategori
class CategoryItem extends StatelessWidget {
  final bool isSelected;
  final String iconPath;

  const CategoryItem(
      {super.key, required this.isSelected, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Image.asset(iconPath, width: 40, height: 40),
        ),
      ],
    );
  }
}

// Widget untuk item makanan
class FoodItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  const FoodItem(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(price),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.add, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
//profile