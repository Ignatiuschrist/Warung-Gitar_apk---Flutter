import 'package:flutter/material.dart';
import 'package:toko_gitar/components/custom_surfix_icon.dart';
import 'package:toko_gitar/components/default_button_custom_color.dart';
import 'package:toko_gitar/db_helper.dart';
import 'package:toko_gitar/screens/Login/LoginScreens.dart';
import 'package:toko_gitar/size_config.dart';
import 'package:toko_gitar/utils/constants.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterForm createState() => _RegisterForm();
}

class _RegisterForm extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtFullName = TextEditingController();
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullName(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmail(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPassword(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "REGISTRASI",
            press: () async {
              if (_formKey.currentState?.validate() ?? false) {
                // Save the new user to SQLite
                await registerUser(txtFullName.text, txtUsername.text, txtEmail.text, txtPassword.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pendaftaran berhasil')),
                );
                Navigator.pushNamed(context, LoginScreen.routeName);
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
            child: Text(
              "Sudah Punya Akun? Masuk Disini",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to save user to SQLite database
  Future<void> registerUser(String fullName, String username, String email, String password) async {
    var dbHelper = DatabaseHelper();
    await dbHelper.insertUser({
      'nama': fullName,
      'username': username,
      'email': email,
      'password': password,
    });
  }

  TextFormField buildFullName() {
    return TextFormField(
      controller: txtFullName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nama Lengkap',
        hintText: 'Masukkan nama lengkap anda',
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan nama lengkap !';
        }
        return null;
      },
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUsername,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Masukkan username anda',
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan username !';
        }
        return null;
      },
    );
  }

  TextFormField buildEmail() {
    return TextFormField(
      controller: txtEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan email anda',
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan email anda !';
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Masukkan email valid !';
        }
        return null;
      },
    );
  }

  TextFormField buildPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan password anda',
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan password !';
        }
        return null;
      },
    );
  }
}
