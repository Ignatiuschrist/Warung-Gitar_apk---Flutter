import 'package:flutter/material.dart';
import 'package:toko_gitar/screens/Login/LoginScreens.dart';
import 'package:toko_gitar/screens/Register/Registrasi.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen()
};
