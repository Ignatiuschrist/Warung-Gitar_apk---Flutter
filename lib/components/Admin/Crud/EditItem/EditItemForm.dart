import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/db_helper.dart';
import 'package:toko_gitar/size_config.dart';

class EditItemForm extends StatefulWidget {
  final Map<String, dynamic> itemData;

  EditItemForm({required this.itemData});

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaController;
  late TextEditingController tipeController;
  late TextEditingController hargaController;
  late TextEditingController merkController;

  File? image;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with item data
    namaController = TextEditingController(text: widget.itemData['nama']);
    tipeController = TextEditingController(text: widget.itemData['tipe']);
    hargaController = TextEditingController(text: widget.itemData['harga']);
    merkController = TextEditingController(text: widget.itemData['merk']);

    if (widget.itemData['gambar'] != '') {
      image = File(widget.itemData['gambar']);
    }
  }

  Future<void> pilihGambar() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      setState(() {
        image = File(pickedFile.path);
      });
    } on PlatformException catch (e) {
      print("Gagal mengambil foto : $e");
    }
  }

  Future<void> updateItem() async {
    var dbHelper = DatabaseHelper();
    await dbHelper.updateItem(widget.itemData['id'], {
      'nama': namaController.text,
      'tipe': tipeController.text,
      'harga': hargaController.text,
      'merk': merkController.text,
      'gambar': image?.path ?? widget.itemData['gambar'],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item berhasil diperbarui')),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildTextFormField('Nama', 'Masukkan nama item', namaController),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildTextFormField('Tipe', 'Masukkan tipe item', tipeController),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildTextFormField('Harga', 'Masukkan harga item', hargaController, keyboardType: TextInputType.number),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildTextFormField('Merk', 'Masukkan merk item', merkController),
            SizedBox(height: getProportionateScreenHeight(30)),

            if (image != null)
              Image.file(image!, height: 150, width: 150, fit: BoxFit.cover),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: pilihGambar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
                child: Text('Pilih Gambar'),
              ),
            ),

            SizedBox(height: getProportionateScreenHeight(30)),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: () async {
                  await updateItem();
                },
                child: Text('UPDATE'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildTextFormField(String label, String hint, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }
}
