import 'package:dicoding_restaurant_app/src/app.dart';
import 'package:dicoding_restaurant_app/src/core/get_it/get_it.dart';
import 'package:dicoding_restaurant_app/src/core/service/connection_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]
  );
  configureDependencies();
  ConnectionStatus connectionStatus = ConnectionStatus.getInstance();
  connectionStatus.initialize();

  runApp(const App());
}

