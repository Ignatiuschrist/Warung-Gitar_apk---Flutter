import 'package:flutter/material.dart';
import 'package:toko_gitar/components/Admin/Crud/EditItem/EditItemForm.dart';

class EditItemComponent extends StatelessWidget {
  final Map<String, dynamic> itemData;

  EditItemComponent({required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: EditItemForm(itemData: itemData),
    );
  }
}
