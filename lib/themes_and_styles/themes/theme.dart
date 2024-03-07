import 'package:flutter/material.dart';

ThemeData myTheme = ThemeData(
brightness: Brightness.dark,

  scaffoldBackgroundColor: const Color.fromRGBO(30, 30, 30, 1.0),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color.fromRGBO(30, 30, 30, 1.0),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(38, 38, 38, 1.0),
    unselectedItemColor: Color.fromRGBO(132, 132, 132, 1.0),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color.fromRGBO(164, 68, 64, 1.0) ,
    elevation: 0,
  ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: Color.fromRGBO(221, 76, 73, 1.0),
        foregroundColor: Color.fromRGBO(244, 230, 230, 1.0),
    ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: const Color.fromRGBO(164, 68, 64, 1.0),
      foregroundColor: Colors.white,
      elevation: 4,
      padding: const EdgeInsets.all(4),
      fixedSize: const Size(130, 30),
    ),
  ),
);