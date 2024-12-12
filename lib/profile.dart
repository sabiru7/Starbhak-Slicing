import 'package:flutter/material.dart';
import 'package:slicing/main.dart';
import 'package:slicing/profile_page.dart';
import 'data.dart';

void main() {
  runApp(const Pfl());
}

class Pfl extends StatelessWidget {
  const Pfl({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> products = [
    Product(imagePath: 'assets/burger.jpg', productName: 'Burger King Medium', price: 'Rp.50.000,00'),
    Product(imagePath: 'assets/cocacola.jpg', productName: 'Coca Cola', price: 'Rp.8.000,00'),
    Product(imagePath: 'assets/burger.jpg', productName: 'Burger King Small', price: 'Rp.35.000,00'),
  ];

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
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
        title: const Text(
          'Produk',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Data()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Tambah Data +',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItem(
                    imagePath: product.imagePath,
                    productName: product.productName,
                    price: product.price,
                    onDelete: () => _deleteProduct(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String imagePath;
  final String productName;
  final String price;

  Product({required this.imagePath, required this.productName, required this.price});
}

class ProductItem extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String price;
  final VoidCallback onDelete;

  const ProductItem({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  price,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}