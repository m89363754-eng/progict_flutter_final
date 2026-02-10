
import 'package:flutter/material.dart';
class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تسجيل الحضور والانصراف',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
'',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 40),

           
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Column(
                  children: [
                    Icon(Icons.qr_code, size: 32),
                    SizedBox(height: 8),
                    Text('QR رمز'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.fingerprint, size: 32),
                    SizedBox(height: 8),
                    Text('بصمة'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
