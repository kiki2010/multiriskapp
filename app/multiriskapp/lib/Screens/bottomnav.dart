import 'package:flutter/material.dart';
import 'package:multiriskapp/Screens/firerisk.dart';
import 'package:multiriskapp/Screens/floodrisk.dart';
import 'package:multiriskapp/Screens/games.dart';
import 'package:multiriskapp/Screens/setting.dart';

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int selectedIndex = 0;

  final screens = [
    fireScreen(),
    Floodscreen(),
    gameScreen(),
    settingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined),
            activeIcon: Icon(Icons.local_fire_department),
            label: 'Fire Risk',
            backgroundColor: colors.surface,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.flood_outlined),
            activeIcon: Icon(Icons.flood),
            label: 'Flood Risk',
            backgroundColor: colors.surface,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports_outlined),
            activeIcon: Icon(Icons.sports_esports),
            label: 'Games',
            backgroundColor: colors.surface,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Setting',
            backgroundColor: colors.surface,
          ),
        ]
      ),
    );
  }
}