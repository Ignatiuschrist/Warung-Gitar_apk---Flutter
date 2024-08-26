import 'package:flutter/material.dart';
import 'package:toko_gitar/db_helper.dart';
import 'dart:io';

class HomeAdminComponent extends StatefulWidget {
  @override
  _HomeAdminComponentState createState() => _HomeAdminComponentState();
}

class _HomeAdminComponentState extends State<HomeAdminComponent> {
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    var dbHelper = DatabaseHelper();
    var items = await dbHelper.getItems();
    setState(() {
      _items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        var item = _items[index];
        return Card(
          child: ListTile(
            leading: item['gambar'] != ''
                ? Image.file(
              File(item['gambar']),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image),
            title: Text(item['nama']),
            subtitle: Text("${item['tipe']} - ${item['harga']}"),
          ),
        );
      },
    );
  }
}
