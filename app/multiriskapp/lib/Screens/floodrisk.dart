import 'package:flutter/material.dart';

class Floodscreen extends StatefulWidget {
  const Floodscreen({super.key});

  @override
  State<Floodscreen> createState() => _FloodscreenState();
}

class _FloodscreenState extends State<Floodscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("flood Risk Screen"),),
    );
  }
}