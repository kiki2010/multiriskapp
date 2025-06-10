import 'package:flutter/material.dart';
import 'package:multiriskapp/Screens/firerisk.dart';
import 'package:multiriskapp/Screens/floodrisk.dart';
import 'package:multiriskapp/Screens/nearcordoba.dart';
import 'package:multiriskapp/Screens/setting.dart';
import 'package:geolocator/geolocator.dart';

class bottomnav extends StatefulWidget {
  final Position position;
  const bottomnav({super.key, required this.position});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int selectedIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      FireScreen(position: widget.position),
      Floodscreen(position: widget.position,),
      nearCordobaScreen(),
      settingScreen(),
    ];
  }

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
        selectedItemColor: Colors.orange,       
        unselectedItemColor: Colors.white,        
        type: BottomNavigationBarType.fixed,     
        backgroundColor: colors.surface,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_fire_department_outlined),
            activeIcon: Icon(Icons.local_fire_department),
            label: 'Fire Risk',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.flood_outlined),
            activeIcon: Icon(Icons.flood),
            label: 'Flood Risk',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports_outlined),
            activeIcon: Icon(Icons.sports_esports),
            label: 'Games',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      )
    );
  }
}