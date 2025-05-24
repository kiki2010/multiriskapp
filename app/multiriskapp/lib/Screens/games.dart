import 'package:flutter/material.dart';

class gameScreen extends StatefulWidget {
  const gameScreen({super.key});

  @override
  State<gameScreen> createState() => _gameScreenState();
}

class _gameScreenState extends State<gameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Games Screen"),),
    );
  }
}