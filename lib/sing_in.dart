import 'package:flutter/material.dart';
import 'package:flutter_application_14/sing_up.dart';

class SingIn extends StatelessWidget {
  const SingIn({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.12),
                Image.asset("assets/images/final_1.jpeg", width: width * 0.2),
                Text(
                  " مرحباٌ بكم فى هودوري!",
                  style: TextStyle(
                    fontSize: 29.2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                  ),
                ),
                Text(
                  " يرجى تسجيل الدخول للمتابعه إلي حسابك",
                  style: TextStyle(
                    fontSize: 19.2,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Amiri',
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                // TextFields...
                Container(
                  width: width * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 237, 234, 234),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "البريد الاكتروني",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      suffixIcon: Icon(Icons.attach_email_outlined),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // TextFields...
                Container(
                  width: width * 0.9,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 237, 234, 234),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "كلمه المرور",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      suffixIcon: Icon(Icons.security),
                    ),
                  ),
                ),

                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(width * 0.8, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  "____________او____________",
                  style: TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SingUp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 252, 254, 255),
                    minimumSize: Size(width * 0.8, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "انشاء حساب",
                    style: TextStyle(
                      color: Color.fromARGB(255, 80, 153, 255),
                      fontWeight: FontWeight.bold,
                      fontSize: 23.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
