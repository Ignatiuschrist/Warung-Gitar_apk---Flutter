import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toko_gitar/utils/constants.dart';
import 'package:toko_gitar/db_helper.dart';
import 'package:toko_gitar/size_config.dart';
import 'package:toko_gitar/screens/Admin/HomeAdminScreens.dart';

class InputItemForm extends StatefulWidget {
  @override
  _InputItemFormState createState() => _InputItemFormState();
}

class _InputItemFormState extends State<InputItemForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController tipeController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController merkController = TextEditingController();

  File? image;

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

  Future<void> insertItem() async {
    var dbHelper = DatabaseHelper();
    await dbHelper.insertItem({
      'nama': namaController.text,
      'tipe': tipeController.text,
      'harga': hargaController.text,
      'merk': merkController.text,
      'gambar': image?.path ?? '',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item berhasil ditambahkan')),
    );

    // Navigate to HomeAdminScreens after successful submission
    Navigator.pushReplacementNamed(context, HomeAdminScreens.routeName);

    // Clear the form after submission
    namaController.clear();
    tipeController.clear();
    hargaController.clear();
    merkController.clear();
    setState(() {
      image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            ElevatedButton(
              onPressed: pilihGambar,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
              child: Text('Pilih Gambar'),
            ),

            SizedBox(height: getProportionateScreenHeight(30)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  insertItem();
                }
              },
              child: Text('SUBMIT'),
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
