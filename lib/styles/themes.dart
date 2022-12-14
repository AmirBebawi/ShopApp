import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    elevation: 0.0,
    color: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 30.0,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyText1:  TextStyle(
      color: defaultColor,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: defaultColor,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: 'Jannah',
);
ThemeData darkTheme = ThemeData(
   primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor("333739"),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    elevation: 0.0,
    backgroundColor: HexColor("333739"),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor("333739"),
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 30.0,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor("333739"),
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
  ),
  textTheme: const TextTheme(
    bodyText1:  TextStyle(
      color: Colors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    bodyText2: TextStyle(
      color: Colors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily: 'Jannah',
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor ,
  ),
);
