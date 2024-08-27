import 'package:flutter/material.dart';
import 'package:toko_gitar/db_helper.dart';
import 'package:toko_gitar/components/Admin/Crud/EditItem/EditItemForm.dart';

class Editscreen extends StatefulWidget {
  static const routeName = '/edit_screen';

  @override
  _EditscreenState createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  Map<String, dynamic>? _itemData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int itemId = ModalRoute.of(context)!.settings.arguments as int;

    _loadItem(itemId);
  }

  Future<void> _loadItem(int id) async {
    var dbHelper = DatabaseHelper();
    var item = await dbHelper.getItemById(id);

    setState(() {
      _itemData = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: _itemData == null
          ? Center(child: CircularProgressIndicator())
          : EditItemForm(itemData: _itemData!),
    );
  }
}
