import 'package:flutter/material.dart';

class fireScreen extends StatefulWidget {
  const fireScreen({super.key});

  @override
  State<fireScreen> createState() => _fireScreenState();
}

class _fireScreenState extends State<fireScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fire Risk Screen"),),
    );
  }
}