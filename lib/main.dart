// Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Pages
import './pages/splash_page.dart';
import './pages/main_page.dart';

void main() {
  // Boot with a lightweight splash that does DI once,
  // then swaps to the real app.
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(const ProviderScope(child: MyApp()));
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flickd',
      // ✅ Go straight to your Home (no Splash in routes to avoid re-running setup)
      home: MainPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
