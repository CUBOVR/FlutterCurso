import 'package:flutter/material.dart';
import 'package:settings_app/settingsScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsScreen();
  }
}
