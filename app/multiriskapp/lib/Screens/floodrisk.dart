import 'package:flutter/material.dart';
import 'package:multiriskapp/main.dart';
import 'package:geolocator/geolocator.dart';

class Floodscreen extends StatefulWidget {
  const Floodscreen({super.key});

  @override
  State<Floodscreen> createState() => _FloodscreenState();
}

class _FloodscreenState extends State<Floodscreen> {
  Position? posicion;

  @override
  void initState() {
    super.initState();
    getActualLocation();
  }

  void getActualLocation() async {
    try {
      final pos = await getUserLocation();
      setState(() {
        posicion = pos;
      });
      print('Latitud: ${pos.latitude}, Longitud: ${pos.longitude}');
    } catch (e) {
      print('Error al obtener la ubicación: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flood Risk Screen"),),
      body: Column(
        children: [
          Text('Latitud: ${posicion?.latitude ?? "Cargando..."}'),
          Text('Longitud: ${posicion?.longitude ?? "Cargando..."}'),
        ],
      ),
    );
  }
}