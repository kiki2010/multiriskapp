import 'package:flutter/material.dart';
import 'package:multiriskapp/Screens/bottomnav.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiriskapp/generated/l10n.dart';
import 'package:multiriskapp/providers/lenguage_provider.dart';
import 'package:multiriskapp/providers/theme.dart';
import 'package:multiriskapp/models/theme_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemePreferences prefs = ThemePreferences();
  String theme = await prefs.getTheme();

  Position position = await getUserLocation();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..setTheme = theme),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MyApp(position: position),
    )
  );
}

class MyApp extends StatelessWidget {
  final Position position;

  const MyApp({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.theme == ThemePreferences.DARK;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'multiRisk app',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate
      ],
      supportedLocales: [
        Locale('en'),
        Locale('es')
      ],
      home: bottomnav(position: position),
    );
  }
}

Future<Position> getUserLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Is not posible to get location.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permission denied forever');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}