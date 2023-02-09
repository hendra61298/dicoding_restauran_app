
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

enum ConnectionStatusValue{
  offline,
  online
}

class ConnectionStatus{
  static final ConnectionStatus _singleton = ConnectionStatus._internal();
  ConnectionStatus._internal();

  static ConnectionStatus getInstance() => _singleton;

  bool hasConnection = false;

  StreamController connectionChangeController = StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch(_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      // connectionChangeController.add(hasConnection);
      handleConnectionChange(hasConnection);
    }

    return hasConnection;
  }

  static void handleConnectionChange(dynamic hasConnection) {
    Color color;
    String message;
    if (!hasConnection) {
      color = Colors.black;
      message = 'Saat ini kamu tidak terhubung ke internet';
    } else {
      color = Colors.blue;
      message = 'Kamu sudah tersambung ke internet lagi';
    }
    App.scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(message)
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
          margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
        )
    );
  }
  void dispose() {
    connectionChangeController.close();
  }
}