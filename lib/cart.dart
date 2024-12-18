import 'package:flutter/material.dart';
import 'package:slicing/done_page.dart';
import 'package:slicing/main.dart';

void main() => runApp(const Cart());

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CartPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Cart items dengan quantity dan price
  final List<CartItem> _cartItems = [
    CartItem(name: 'Burger King Medium', price: 50000, quantity: 1, imagePath: 'assets/burger.jpg'),
    CartItem(name: 'Ice Cream BK', price: 23000, quantity: 1, imagePath: 'assets/icecream.jpeg'),
    CartItem(name: 'Burger Large', price: 50000, quantity: 1, imagePath: 'assets/bigburger.jpeg'),
  ];

  int get _total {
    int subtotal = _cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
    int tax = (subtotal * 0.12).round(); 
    return subtotal + tax;
  }

  void _incrementQuantity(int index) {
    setState(() {
      _cartItems[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
        title: const Text('Cart'),
        backgroundColor: const Color.fromARGB(255, 74, 244, 221),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return _buildCartItem(
                  item.name,
                  item.price,
                  item.quantity,
                  item.imagePath,
                  () => _incrementQuantity(index),
                  () => _decrementQuantity(index),
                  () => _deleteItem(index),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryRow('PPN 11%', 'Rp ${(_total - (_total / 1.11).round()).toStringAsFixed(2)}'),
                _buildSummaryRow('Total Belanja', 'Rp ${(_total / 1.11).round().toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                _buildSummaryRow('Total Pembayaran', 'Rp $_total', bold: true),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DonePage()),
                      );
                    },
                    child: const Text('Checkout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: const EdgeInsets.all(16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(String title, int price, int quantity, String imagePath, VoidCallback onIncrement, VoidCallback onDecrement, VoidCallback onDelete) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset(imagePath),
        title: Text(title),
        subtitle: Text('Rp ${price * quantity}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: onDecrement,
            ),
            Text(quantity.toString()), // Display quantity
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: onIncrement,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 16)),
        Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontSize: 16)),
      ],
    );
  }
}

class CartItem {
  final String name;
  final int price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });
}