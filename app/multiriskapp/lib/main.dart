import 'package:flutter/material.dart';
import 'package:multiriskapp/Screens/bottomnav.dart';
import 'package:multiriskapp/Screens/firerisk.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'multiRisk app',
      theme: ThemeData(
        colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.orange, onPrimary: Colors.orangeAccent, secondary: Colors.cyan, onSecondary: Colors.cyanAccent, error: Colors.red, onError: Colors.redAccent, surface: Colors.white24, onSurface: Colors.white70),
        primarySwatch: Colors.orange,
        fontFamily: 'Arial',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          )
        )
      ),
      home: bottomnav(),
    );
  }
}