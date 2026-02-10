import 'package:flutter/material.dart';
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              image: AssetImage("assets/images/screen2.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 40),
        Text(
          "Seamless Collaboration",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Connect your team and streamline workflows with real-time collaboration tools built for modern enterprises.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}