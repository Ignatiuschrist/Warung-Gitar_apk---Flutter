import 'package:flutter/material.dart';
import 'package:toko_gitar/components/Admin/Crud/InputItem/InputItemForm.dart';

class InputItemComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InputItemForm(), // Integrating the form
    );
  }
}
