import 'package:flutter/material.dart';

class settingScreen extends StatefulWidget {
  const settingScreen({super.key});

  @override
  State<settingScreen> createState() => _settingScreenState();
}

class _settingScreenState extends State<settingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting Screen"),),
      body: const Center(
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(),
              Text('Language'),
            Divider(),
              Text('Theme'),
            Divider(),
              Text('Repeat Tutorial'),
            Divider(),
          ],
        ),
      ),
    );
  }
}