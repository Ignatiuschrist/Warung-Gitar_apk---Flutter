import 'package:flutter/material.dart';
import 'package:toko_gitar/screens/Admin/Crud/InputScreen.dart';
import 'package:toko_gitar/screens/Login/LoginScreens.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/components/Admin/HomeAdminComponent.dart';

class HomeAdminScreens extends StatelessWidget {
  static var routeName = "/home_admin_screens";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "WarungGitar",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.home,
          color: mTitleColor,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, InputScreen.routeName);
            },
            child: Row(
              children: [
                Icon(Icons.add, color: mTitleColor),
                Text(
                  "Input Data",
                  style: TextStyle(
                    color: mTitleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: HomeAdminComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool confirmLogout = await _confirmLogout(context);
          if (confirmLogout) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
                  (Route<dynamic> route) => false,
            );
          }
        },
        backgroundColor: kColorRedSlow,
        child: Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<bool> _confirmLogout(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi Logout', style: mTitleStyle),
          content: Text('Apakah Anda yakin ingin logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Tidak', style: mTitleStyle),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Ya', style: mTitleStyle),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
