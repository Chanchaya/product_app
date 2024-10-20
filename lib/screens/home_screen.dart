import 'package:flutter/material.dart';
import 'product_list_screen.dart'; // นำเข้า ProductListScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าแรก'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // รูปภาพจาก URL
            Image.network(
              'https://scontent-bkk1-2.xx.fbcdn.net/v/t39.30808-1/290764775_140400731925871_3868991413964026214_n.jpg?stp=dst-jpg_s200x200&_nc_cat=100&ccb=1-7&_nc_sid=0ecb9b&_nc_ohc=I-cnMdp4VqcQ7kNvgF92vom&_nc_zt=24&_nc_ht=scontent-bkk1-2.xx&_nc_gid=AUV6RzF1lXwlYZPR2cJl0Tm&oh=00_AYBLvC0UyAdWxElE0HXptAWwptnsodVUTVfsyusofIpxgw&oe=6714578C', // เปลี่ยนเป็น URL ของรูปที่คุณต้องการ
              width: 150, // กำหนดความกว้างของรูป
              height: 150, // กำหนดความสูงของรูป
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null)
                  return child; // หากโหลดเสร็จแล้วให้แสดงรูป
                return Center(
                  child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null),
                );
              },
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Text('ไม่สามารถโหลดรูปภาพ');
              },
            ),
            const SizedBox(height: 20), // เว้นระยะห่างระหว่างรูปภาพและข้อความ
            const Text(
              'วรุฬภรณื ใจเมือง 65010912611',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // เว้นระยะห่าง
            ElevatedButton(
              onPressed: () {
                // คลิกแล้วไปที่หน้ารายการสินค้า
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductListScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('ไปที่รายการเมนูอาหาร'),
            ),
          ],
        ),
      ),
    );
  }
}
