import 'package:flutter/material.dart';
import 'product_add_screen.dart';
import 'product_view_screen.dart';
import '../services/product_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<dynamic>> futureProduct;
  @override
  void initState() {
// TODO: implement initState

    super.initState();
    futureProduct = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการข้อมูลรูปภาพ'),
        backgroundColor: const Color.fromARGB(255, 255, 139, 7),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: futureProduct,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('ไม่พบรายการข้อมูลรูปภาพ'));
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data![index]['proname']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductViewScreen(
                                      productData: snapshot.data![index],
                                    )),
                          );
                        },
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductAddScreen()),
          );
        },
        tooltip: 'เพิ่มข้อมูลสมาชิกใหม่',
        child: const Icon(Icons.add),
      ),
    );
  }
}
