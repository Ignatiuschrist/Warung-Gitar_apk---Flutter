import 'package:flutter/material.dart';
import 'package:toko_gitar/components/Register/RegisterComponent.dart';
import 'package:toko_gitar/size_config.dart';

class RegisterScreen extends StatelessWidget {

  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: RegisterComponent(),
    );
  }
}
