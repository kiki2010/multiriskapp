import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiriskapp/providers/theme.dart';
import 'package:multiriskapp/models/theme_preferences.dart';
import 'package:multiriskapp/providers/lenguage_provider.dart';

class settingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.theme == ThemePreferences.DARK;
    final currentLocale = Provider.of<LanguageProvider>(context).currentLocale;
    
    return Scaffold(
      appBar: AppBar(title: Text("Setting Screen"),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(),
              Text('Change Lenguage'),
              DropdownButton<String>(
                value: currentLocale.languageCode,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    Provider.of<LanguageProvider>(context, listen: false)
                      .setLanguage(newValue);
                  }
                },
                items: const [
                  DropdownMenuItem<String>(
                    value: 'en',
                    child: Text('English'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'es',
                    child: Text('Español'),
                  ),
                ],
              ),
            Divider(),
              SwitchListTile(
                title: Text('Dark Theme'),
                value: isDark,
                onChanged: (value) {
                  themeProvider.setTheme =
                    value ? ThemePreferences.DARK : ThemePreferences.LIGHT;
                },
              ),
            Divider(),
              Text('If you want to make a suggestion, do not hesitate to write to multiriskapp@gmail.com'),
            Divider(),
          ],
        ),
      ),
    );
  }
}