import 'package:flutter/material.dart';
import 'package:toko_gitar/db_helper.dart';
import 'package:toko_gitar/screens/Admin/Crud/EditScreen.dart';
import 'dart:io';
import 'package:toko_gitar/utils/constants.dart';

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
      _items = List<Map<String, dynamic>>.from(items);
    });
  }

  Future<void> _deleteItem(int id, int index) async {
    var dbHelper = DatabaseHelper();
    await dbHelper.deleteItem(id);

    setState(() {
      _items.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item berhasil dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        var item = _items[index];
        return Card(
          elevation: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          color: Colors.white,
          child: ListTile(
            onTap: () async {
              final result = await Navigator.pushNamed(
                context,
                Editscreen.routeName,
                arguments: item['id'],
              );

              if (result == true) {
                _loadItems();
              }
            },
            leading: item['gambar'] != ''
                ? Image.file(
              File(item['gambar']),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image),
            title: Text(item['nama']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${item['tipe']} - ${item['merk']}"),
                SizedBox(height: 5),
                Text("Harga Rp.${item['harga']}"),
              ],
            ),
            trailing: GestureDetector(
              onTap: () async {
                bool confirm = await _confirmDelete(context);
                if (confirm) {
                  _deleteItem(item['id'], index);
                }
              },
              child: Icon(
                Icons.delete,
                color: kColorRedSlow,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi', style: mTitleStyle),
          content: Text('Apakah Anda yakin ingin menghapus item ini?'),
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
