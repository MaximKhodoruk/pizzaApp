import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    background: Colors.white70,
    primary: Colors.red,
    secondary: Colors.white,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.black),
  ),
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Colors.white10,
    primary: Colors.red,
    secondary: Colors.black,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Colors.white),
  ),
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(color: Colors.white),
  ),
);
