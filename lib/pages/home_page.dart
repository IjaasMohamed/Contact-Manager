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
  final contactsCollection =
      FirebaseFirestore.instance.collection("contacts").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Contacts"),
      ),
      body: StreamBuilder(
        stream: contactsCollection,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return Center(
                child: Text(
                  "No contacts yet",
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final contact = documents[index].data() as Map<String, dynamic>;
                final contactId = documents[index].id;
                final String name = contact["name"];
                final String email = contact['email'];
                final phone = contact['phone'];
                final String avatar =
                    "https://avatars.dicebear.com/api/avataaars/$name.png";
                return ListTile(
                  title: Text(name),
                  subtitle: Text("$phone \n$email"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(IconlyBroken.edit))
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
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
