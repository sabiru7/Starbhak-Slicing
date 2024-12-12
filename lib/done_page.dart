import 'package:flutter/material.dart';
import 'package:slicing/main.dart';

class DonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selesai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            Text('Pesanan Anda Telah Selesai', style: TextStyle(fontSize: 24)),
            Text('Terima kasih telah order makanan kami', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Text('Kembali ke Beranda'),
            ),
          ],
        ),
      ),
    );
  }
}