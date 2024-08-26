import 'package:flutter/material.dart';
import 'package:toko_gitar/components/custom_surfix_icon.dart';
import 'package:toko_gitar/components/default_button_custom_color.dart';
import 'package:toko_gitar/screens/Register/Registrasi.dart';
import 'package:toko_gitar/components/Reset/ResetPassword.dart';
import 'package:toko_gitar/size_config.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/db_helper.dart';

class SignForm extends StatefulWidget {
  @override
  _SignForm createState() => _SignForm();
}

class _SignForm extends State<SignForm> {

  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;

  TextEditingController txtUsername = TextEditingController(),
      txtPassword = TextEditingController();

  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserName(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildUserPassword(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  }),
              Text("Tetap Masuk"),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ResetPasswordPage.routeName);  // Navigate to reset password page
                },
                child: Text("Lupa Password",
                  style: TextStyle(
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          DefaultButtonCustomeColor(
            color: kPrimaryColor,
            text: "MASUK",
            press: () async {
              if (_formKey.currentState!.validate()) {
                // Call function to check credentials
                bool loginSuccess = await checkLogin(
                    txtUsername.text, txtPassword.text);
                if (loginSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login Berhasil'))
                  );
                  Navigator.pushNamed(context, "/home_admin_screens");
                  // Navigate to the next screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Username atau Password salah')));
                }
              }
            },
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RegisterScreen.routeName);
            },
            child: Text("Belum Punya Akun ? Daftar Disini",
              style: TextStyle(
                  decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  TextFormField buildUserName() {
    return TextFormField(
      controller: txtUsername,
      keyboardType: TextInputType.text,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Username',
          hintText: 'Masukkan Username Anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg",
          )
      ),
    );
  }

  TextFormField buildUserPassword() {
    return TextFormField(
      controller: txtPassword,
      obscureText: true,
      style: mTitleStyle,
      decoration: InputDecoration(
          labelText: 'Password',
          hintText: 'Masukkan Password Anda',
          labelStyle: TextStyle(
              color: focusNode.hasFocus ? mSubtitleColor : kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg",
          )
      ),
    );
  }

  Future<bool> checkLogin(String username, String password) async {
    var dbHelper = DatabaseHelper();
    List<Map<String, dynamic>> users = await dbHelper.getUsers();

    for (var user in users) {
      if (user['username'] == username && user['password'] == password) {
        return true;
      }
    }
    return false;
  }
}
