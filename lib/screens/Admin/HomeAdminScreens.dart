import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toko_gitar/screens/Admin/Crud/InputScreen.dart';
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
                )
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
        onPressed: () {},
        backgroundColor: kColorRedSlow,
        child: Icon(
          Icons.logout,
          color: Colors.white,
        ),
      ),
    );
  }
}
