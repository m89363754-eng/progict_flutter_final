import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
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
                  "Create Account",
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Amiri',
                  ),
                ),
                Text(
                  "Sign up to get started",
                  style: TextStyle(fontSize: 14, fontFamily: 'Amiri'),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Container(
                    width: 310,
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
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
                    child: Column(
                      children: [
                        buildField(
                          width,
                          label: "Full Name",
                          hint: "John Doe",
                          icon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        buildField(
                          width,
                          label: "Email address",
                          hint: "you@company.com",
                          icon: Icons.attach_email_outlined,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your email";
                            }
                            if (!value.contains("@")) {
                              return "Invalid email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        buildField(
                          width,
                          label: "Password",
                          hint: "Enter password",
                          icon: Icons.security,
                          obscure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }
                            if (value.length < 6) {
                              return "Password too short";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print("Account Created");
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
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Already have an account? Sign in",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(
    double width, {
    required String label,
    required String hint,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Text(label),
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
            obscureText: obscure,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              suffixIcon: Icon(icon),
            ),
          ),
        ),
      ],
    );
  }
}
