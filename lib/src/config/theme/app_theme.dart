
import 'package:flutter/material.dart';

class AppTheme{
  static final themeData = ThemeData(
    primaryColor: Colors.lightBlueAccent,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    )

  );
}