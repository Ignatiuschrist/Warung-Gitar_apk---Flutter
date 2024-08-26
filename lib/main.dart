import 'package:flutter/material.dart';
import 'package:toko_gitar/routes.dart';
import 'package:toko_gitar/screens/Login/LoginScreens.dart';
import 'package:toko_gitar/theme.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Warung Gitar",
      theme: theme(),
      initialRoute: LoginScreen.routeName,
      routes: routes,
    ),
  );
}
