import 'package:flutter/material.dart';
import 'package:flutter_application_14/sing_up.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final _formKey = GlobalKey<FormState>();

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
                  " Welcome back",
                  style: TextStyle(
                    fontSize: 29.2,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                  ),
                ),
                Text(
                  "Sign in to your account to continue",
                  style: TextStyle(fontSize: 14.2, fontFamily: 'Amiri'),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Container(
                    height: 460,
                    width: 310,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.2,
                        color: Colors.grey.shade400,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 4,
                          blurRadius: 6,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: Text("Email address"),
                            ),
                            SizedBox(height: 6),
                            Container(
                              width: width * 0.9,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 237, 234, 234),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter your email";
                                  }
                                  if (!value.contains("@")) {
                                    return "Invalid email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "you@company.com",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  suffixIcon: Icon(Icons.attach_email_outlined),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.05),
                              child: Text("Password"),
                            ),
                            SizedBox(height: 6),
                            Container(
                              width: width * 0.9,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 237, 234, 234),
                              ),
                              child: TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter password";
                                  }
                                  if (value.length < 6) {
                                    return "Password too short";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your password",
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  suffixIcon: Icon(Icons.security),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("Login Success ✅");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              1,
                              27,
                              49,
                            ),
                            minimumSize: Size(width * 0.8, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "___Or continue with ___",
                          style: TextStyle(fontSize: 11),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 241, 238, 238),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.facebook,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 241, 238, 238),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.apple, size: 30),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SingUp()),
                        );
                      },
                      child: Text(
                        "sign up",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
