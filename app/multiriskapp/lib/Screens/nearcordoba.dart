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
      appBar: AppBar(
        title: Text("Places Near Cordoba"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         const Divider(),
         DropdownButton(
          value: "",
          onChanged: (value) {
            
          },
          items: const [
            DropdownMenuItem<String>(
              value: 'all',
              child: Text("All"),
            ),
            DropdownMenuItem<String>(
              value: 'ForestandParks',
              child: Text("Forest and Parks"),
            ),
            DropdownMenuItem<String>(
              value: 'Beach',
              child: Text("Beachs"),
            ),
            DropdownMenuItem<String>(
              value: 'Campings',
              child: Text("Campings"),
            ),
          ],
         ),
         const Divider(), 
        ],
      ),
    );
  }
}