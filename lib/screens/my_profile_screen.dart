import 'package:flutter/material.dart';
import 'package:product_app1/screens/product_view_screen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            //ชื่อ
            //
            //

            ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductViewScreen()),
                  );
                },
                label: Text('แก้ไขข้อมูล'))
          ],
        ),
      ),
    );
  }
}
