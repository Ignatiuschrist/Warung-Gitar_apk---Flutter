import 'package:flutter/material.dart';
import 'package:toko_gitar/size_config.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/components/Register/RegisterForm.dart';

class RegisterComponent extends StatefulWidget {
  @override
  _RegisterComponentState createState() => _RegisterComponentState();
}

class _RegisterComponentState extends State<RegisterComponent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Center(
                  child: Text(
                    "Registrasi",
                    style: mTitleStyle,
                  ),
                ),
                SizedBox(height: 30),
                RegisterForm(), // Use the RegisterForm widget
              ],
            ),
          ),
        ),
      ),
    );
  }
}
