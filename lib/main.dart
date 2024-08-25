import 'package:flutter/material.dart'; // Import Flutter material package
import 'package:toko_gitar/routes.dart';
import 'package:toko_gitar/screens/Login/LoginScreens.dart';
import 'package:toko_gitar/theme.dart';

void main() async {
  runApp(
    MaterialApp(
      title: "Warung Gitar",
      theme: theme(),
      initialRoute: LoginScreen.routeName,
      routes: routes,
    ),
  );
}
