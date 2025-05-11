import 'package:flutter/material.dart';
import 'package:sqlite/models/contact.dart';

class EntryForm extends StatefulWidget {
  final Contact contact;

  EntryForm(this.contact);

  @override
  EntryFormState createState() => EntryFormState(this.contact);
}

class EntryFormState extends State<EntryForm> {
  Contact contact;

  EntryFormState(this.contact);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (contact != null) {
      nameController.text = contact.name;
      phoneController.text = contact.phone;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(contact == null ? 'Tambah Data' : 'Ubah Data'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        child: ListView(
          children: <Widget>[
            // Nama
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            // Nomor HP
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Nomor HP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
            // Tombol aksi
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: <Widget>[
                  // Tombol Simpan
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Simpan', textScaleFactor: 1.5),
                      onPressed: () {
                        if (contact == null) {
                          contact = Contact(
                            nameController.text,
                            phoneController.text,
                          );
                        } else {
                          contact.name = nameController.text;
                          contact.phone = phoneController.text;
                        }
                        Navigator.pop(context, contact);
                      },
                    ),
                  ),
                  SizedBox(width: 5.0),
                  // Tombol Batal
                  Expanded(
                    child: ElevatedButton(
                      child: Text('Batal', textScaleFactor: 1.5),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
