import 'dart:convert';
import 'package:flicked_app/services/http_services.dart';
import 'package:flicked_app/services/movie_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import '../models/app_config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      await setUp(); // load config
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('home'); // go to main
    });
  }

  Future<void> setUp() async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString("assets/config/main.json");
    final configData = json.decode(configFile);

    getIt.registerSingleton<AppConfig>(
      AppConfig(
        BASE_API_URL: configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
        API_KEY: configData["API_KEY"],
      ),
    );

    getIt.registerSingleton<HTTPServices>(HTTPServices());

    getIt.registerSingleton<MovieService>(MovieService());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
