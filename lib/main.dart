import 'package:flutter/material.dart';
import 'package:flutter_application_14/sing_in.dart';

void main() {
  runApp(const MyApp());
}

//elktbveolrve
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: SingIn());
  }
}
