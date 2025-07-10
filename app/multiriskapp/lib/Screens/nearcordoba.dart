import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiriskapp/generated/l10n.dart';
//import 'package:url_launcher/url_launcher.dart';

class nearCordobaScreen extends StatefulWidget {
  const nearCordobaScreen({super.key});

  @override
  State<nearCordobaScreen> createState() => _nearCordobaScreenState();
}

class _nearCordobaScreenState extends State<nearCordobaScreen> {
  String selectedCategory = 'Campings';
  Position? currentPosition;

  final Map<String, IconData> categoryIcons = {
    'Campings': Icons.backpack,
    'Parks and Forests': Icons.forest,
    'beaches': Icons.beach_access,
  };

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = position;
    });
  }

  Stream<QuerySnapshot> _categoryStream() {
    return FirebaseFirestore.instance
      .collection(selectedCategory)
      .snapshots();
  }

  double _calculateDistance(List<dynamic> location) {
    if (currentPosition == null || location.length != 2) return 0;
    final lat = double.tryParse(location[0]) ?? 0;
    final lng = double.tryParse(location[1]) ?? 0;
    return Geolocator.distanceBetween(
      currentPosition!.latitude, currentPosition!.longitude, lat, lng
    ) / 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).placesNearCordoba),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(),
          DropdownButton(
            value: selectedCategory,
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
              });
            },
            items: categoryIcons.keys.map((category) {
              return DropdownMenuItem(
                value:  category,
                child: Text(category),
              );
            }).toList(),            
          ),
          const Divider(),
          Expanded(
            child: StreamBuilder(
              stream: _categoryStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text(AppLocalizations.of(context).loadData));
                }
                final docs = snapshot.data!.docs;
                
                if (docs.isEmpty) {
                  return Center(child: Text(AppLocalizations.of(context).noFound));
                }
                
                return ListView(
                  children: docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final name = data['name'] ?? 'Unnamed';
                    final location = data['location'] ?? ['0', '0'];
                    final services = data['services'] ?? '';
                    //final link = data['link'] ?? '';
                    final distance = _calculateDistance(location).toStringAsFixed(2);

                    return ExpansionTile(
                      leading: Icon(categoryIcons[selectedCategory]),
                      title: Text(name),
                      subtitle: Text("$distance km"),
                      children: [
                        ListTile(
                          title: Text('Services $services'),
//                          subtitle: link.isNotEmpty
//                            ? TextButton(
//                              onPressed: () async {
//                                final rawLink = link.trim();
//                                final finalUrl = rawLink.startsWith('http') ? rawLink : 'https://$rawLink';
//                                final uri = Uri.parse(finalUrl);
//                                if (await canLaunchUrl(uri)) {
//                                  await launchUrl(uri, mode: LaunchMode.externalApplication);
//                                } else {
//                                  ScaffoldMessenger.of(context).showSnackBar(
//                                    SnackBar(content: Text("The link couldn't be open")),
//                                  );
//                                }
//                              },
//                              child: const Text(
//                                'Open Link',
//                                style: TextStyle(decoration: TextDecoration.underline),
//                              ),
//                            )
//                          : const Text('')
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}