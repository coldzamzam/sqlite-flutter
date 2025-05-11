import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqlite/helpers/dbhelper.dart';
import 'package:sqlite/models/contact.dart';
import 'package:sqlite/ui/entryform.dart';
import 'package:sqflite/sqflite.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  List<Contact> contactList = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Database'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, Contact('', ''));
          if (contact != null && contact.name.isNotEmpty && contact.phone.isNotEmpty) {
            addContact(contact);
          }
        },
      ),
    );
  }

  Future<Contact> navigateToEntryForm(BuildContext context, Contact contact) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntryForm(contact)),
    );
    return result;
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(contactList[index].name),
            subtitle: Text(contactList[index].phone),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteContact(contactList[index]);
              },
            ),
            onTap: () async {
              var contact = await navigateToEntryForm(context, contactList[index]);
              if (contact != null && contact.name.isNotEmpty && contact.phone.isNotEmpty) {
                editContact(contact);
              }
            },
          ),
        );
      },
    );
  }

  void addContact(Contact object) async {
    int result = await dbHelper.insert(object);
    print("Add contact result: $result"); // Debugging
    if (result > 0) {
      updateListView();
    }
  }

  void editContact(Contact object) async {
    int result = await dbHelper.update(object);
    print("Edit contact result: $result"); // Debugging
    if (result > 0) {
      updateListView();
    }
  }

  void deleteContact(Contact object) async {
    int result = await dbHelper.delete(object.id);
    print("Delete contact result: $result"); // Debugging
    if (result > 0) {
      updateListView();
    }
  }

  void updateListView() async {
    List<Contact> contactList = await dbHelper.getContactList();
    setState(() {
      this.contactList = contactList;
      this.count = contactList.length;
    });
  }
}
