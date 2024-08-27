import 'package:flutter/material.dart';
import 'package:toko_gitar/screens/Admin/Crud/EditScreen.dart';
import 'package:toko_gitar/screens/Admin/Crud/InputScreen.dart';
import 'package:toko_gitar/screens/Login/LoginScreens.dart';
import 'package:toko_gitar/screens/Register/Registrasi.dart';
import 'package:toko_gitar/components/Reset/ResetPassword.dart';
import 'package:toko_gitar/screens/Admin/HomeAdminScreens.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  ResetPasswordPage.routeName: (context) => ResetPasswordPage(),
  HomeAdminScreens.routeName: (context) => HomeAdminScreens(),
  InputScreen.routeName: (context) => InputScreen(),
  Editscreen.routeName: (context) => Editscreen(),
};
