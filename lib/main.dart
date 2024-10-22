import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/config.dart';

void main() {
  runApp(ProviderScope(
    child: DevicePreview(
      backgroundColor: Colors.blueAccent,
      tools: const [
        DeviceSection(
          orientation: false,
        ),
        SystemSection(
          locale: false,
        ),
        // AccessibilitySection(),
        SettingsSection()
      ],
      builder: (context) => const MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
