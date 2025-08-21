import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

// Services
import '../services/http_services.dart';
import '../services/movie_service.dart';

// Model
import '../models/app_config.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({super.key, required this.onInitializationComplete});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final setupFuture = _setup(); // service setup
    final delayFuture = Future.delayed(
      const Duration(seconds: 5),
    ); // 5 sec delay

    // Wait for BOTH: setup + delay
    await Future.wait([setupFuture, delayFuture]);

    // then go to app
    widget.onInitializationComplete();
  }

  Future<void> _setup() async {
    final getIt = GetIt.instance;

    final configFile = await rootBundle.loadString('assets/config/main.json');
    final cfg = jsonDecode(configFile);

    if (!getIt.isRegistered<AppConfig>()) {
      getIt.registerSingleton<AppConfig>(
        AppConfig(
          BASE_API_URL: cfg['BASE_API_URL'],
          BASE_IMAGE_API_URL: cfg['BASE_IMAGE_API_URL'],
          API_KEY: cfg['API_KEY'],
        ),
      );
    }

    if (!getIt.isRegistered<HTTPService>()) {
      getIt.registerSingleton<HTTPService>(HTTPService());
    }

    if (!getIt.isRegistered<MovieService>()) {
      getIt.registerSingleton<MovieService>(MovieService());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flickd',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
