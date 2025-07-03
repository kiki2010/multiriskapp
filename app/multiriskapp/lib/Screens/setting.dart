import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:multiriskapp/providers/theme.dart';
import 'package:multiriskapp/models/theme_preferences.dart';

class settingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.theme == ThemePreferences.DARK;
    
    return Scaffold(
      appBar: AppBar(title: Text("Setting Screen"),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(),
              Text('Language'),
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
              Text('Repeat Tutorial'),
            Divider(),
          ],
        ),
      ),
    );
  }
}