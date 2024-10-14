import 'package:flutter/material.dart';
import 'package:product_app1/screens/product_list_screen.dart';
import 'package:product_app1/screens/product_view_screen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'ชัญชญา ตั้งเกษมสุข',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductListScreen()),
                  );
                },
                label: Text('แสดงรายการสินค้า'))
          ],
        ),
      ),
    );
  }
}
