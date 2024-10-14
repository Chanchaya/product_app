import 'package:flutter/material.dart';
import 'package:product_app1/screens/product_add_screen.dart';
import '../services/product_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductUpdateScreen extends StatefulWidget {
  final Map productData;
  const ProductUpdateScreen({super.key, required this.productData});

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _pronameController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();
  final ProductService _productService = ProductService();

  Future<void> _pickImage(ImageSource source) async {
//ประกาศตัวแปร pickedFile สําหรับจัดเก็บไฟลgรูปภาพที่เลือก
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
//กําหนดให8ตัวแปร _image เก็บข8อมูลไฟลgรูปภาพที่อยูKในตัวแปร pickedFile
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไชข้อมูลสินค้าใหม่'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
//แสดงรูปภาพที่เลือก
              SizedBox(
                  height: 150,
                  child: _image != null
                      ? Image.file(_image!)
                      : Image.network(ProductService().imageUrl +
                          "/" +
                          widget.productData['image'])),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    child: Text('ถ่ายรูป'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    child: Text('เลือกรูปจากแกลเลอรี'),
                  ),
                ],
              ),
              TextField(
                controller: _pronameController,
                decoration: InputDecoration(labelText: 'ชื่อสินค้า'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'ราคา'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(
                height: 20,
              ),

// แก้ไขข้อมูล
              ElevatedButton.icon(
                  onPressed: () async {
                    if (_image != null) {
                      String proname = _pronameController.text;
                      double price = double.parse(_priceController.text);
//เรียกใช8 api เพื่อเพิ่มข8อมูลใหมK
                      final upload = await _productService.updateProduct(
                          widget.productData['proId'], _image!, proname, price);
//ตรวจสอบตัวแปร upload
                      if (upload != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('สําเร็จ'),
                        ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductAddScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color.fromARGB(255, 255, 149, 0),
                          content: Text('ผิดพลาด'),
                        ));
                      }
                    }
                  },
                  label: Text('แก้ไขข้อมูล')),

// ลบข้อมูล
              ElevatedButton.icon(
                  onPressed: () async {
                    if (_image != null) {
                      String proname = _pronameController.text;
                      double price = double.parse(_priceController.text);
//เรียกใช8 api เพื่อเพิ่มข8อมูลใหมK
                      final upload = await _productService
                          .deleteProduct(widget.productData['proId']);
//ตรวจสอบตัวแปร upload
                      if (upload != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('สําเร็จ'),
                        ));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductAddScreen()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color.fromARGB(255, 255, 149, 0),
                          content: Text('ผิดพลาด'),
                        ));
                      }
                    }
                  },
                  label: Text('ลบข้อมูล'))
            ],
          ),
        ),
      ),
    );
  }
}
