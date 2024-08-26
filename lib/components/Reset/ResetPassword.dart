import 'package:flutter/material.dart';
import 'package:toko_gitar/components/default_button_custom_color.dart';
import 'package:toko_gitar/size_config.dart';
import 'package:toko_gitar/utils/constants.dart';

class ResetPasswordPage extends StatefulWidget {
  static String routeName = "/reset_password";  // Define the route name

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenHeight(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                "Reset Password",
                style: mTitleStyle,
              ),
              SizedBox(height: getProportionateScreenHeight(30)),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: txtEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Masukkan email Anda',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan email Anda!';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Masukkan email valid!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    DefaultButtonCustomeColor(
                      color: kPrimaryColor,
                      text: "KIRIM",
                      press: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Handle password reset logic here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tautan reset password telah dikirim ke email Anda')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
