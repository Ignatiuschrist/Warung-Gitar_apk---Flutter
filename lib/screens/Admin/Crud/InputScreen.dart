import 'package:flutter/material.dart';
import 'package:toko_gitar/components/Admin/Crud/InputItem/InputItemComponent.dart';
import 'package:toko_gitar/utils/constants.dart';

class InputScreen extends StatelessWidget {
  static var routeName = '/input_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Input Item",
          style: TextStyle(color: mTitleColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: InputItemComponent(), // Integrating the InputItemComponent
    );
  }
}
