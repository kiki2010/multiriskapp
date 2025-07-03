import 'package:flutter/material.dart';

class nearCordobaScreen extends StatefulWidget {
  const nearCordobaScreen({super.key});

  @override
  State<nearCordobaScreen> createState() => _nearCordobaScreenState();
}

class _nearCordobaScreenState extends State<nearCordobaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Places Near Me"),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(),
            Text("Parks and Campings"),
            Divider(),
            Text("Beaches"),
            Divider(),
            Text("Campings"),
            Divider(),
          ],
        ),
      ),
    );
  }
}