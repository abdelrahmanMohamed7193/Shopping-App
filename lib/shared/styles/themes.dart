import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppingapp/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.deepPurple,
  floatingActionButtonTheme:  FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: defaultColor ,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed ,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0 ,
    backgroundColor: Colors.white,
  )

);
