import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_manager/pages/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  final contactsCollection = FirebaseFirestore.instance.collection("contacts").
  snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Contacts"),
      ),
      body:StreamBuilder(
        stream: contactsCollection,
        builder: (context, snapshot){
        if (snapshot.hasData) {
          return const Text("We have data");
        } 
        else if (snapshot.hasError){
          return const Center(
            child: Text("There as an error"),
          );
        }
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddContactPage(),
              ));
        },
        label: const Text("Add Contact"),
        icon: const Icon(IconlyBroken.document),
      ),
    );
  }
}
