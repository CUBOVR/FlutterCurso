import 'package:flutter/material.dart';
import 'package:settings_app/preferenceKeys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMorde = false;
  String _language = "es";
  double _fontSize = 16;

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  _loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMorde = prefs.getBool(PreferenceKeys.darkMode) ?? false;
      _language = prefs.getString(PreferenceKeys.language) ?? "es";
      _fontSize = prefs.getDouble(PreferenceKeys.fontSize) ?? 16;
    });
  }

  _savePreference(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _darkMorde ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(title: Text("Configuration")),
        body: Column(
          children: [
            SwitchListTile(
              title: Text("Modo oscuro"),
              value: _darkMorde,
              onChanged: (darkMorde) {
                setState(() => _darkMorde = darkMorde);
                _savePreference(PreferenceKeys.darkMode, darkMorde);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: DropdownButtonFormField(
                value: _language,
                items: [
                  DropdownMenuItem(value: "es", child: Text("Español")),
                  DropdownMenuItem(value: "en", child: Text("Inglés")),
                  DropdownMenuItem(value: "ch", child: Text("Chino")),
                ],
                onChanged: (language) {
                  if (language != null) {
                    setState(() => _language = language);
                    _savePreference(PreferenceKeys.language, language);
                  }
                },
                decoration: InputDecoration(label: Text("Idioma")),
              ),
            ),
            Text("Tamaño de la fuente ${_fontSize.toStringAsFixed(0)}"),
            Slider(
              value: _fontSize,
              min: 14,
              max: 24,
              divisions: 10,
              onChanged: (fontSize) {
                setState(() => _fontSize = fontSize);
                _savePreference(PreferenceKeys.fontSize, fontSize);
              },
            ),
          ],
        ),
      ),
    );
  }
}
