import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_manager/pages/add_contact_page.dart';
import 'package:contact_manager/pages/edit_contact_page.dart';
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
  void deleteContact(String id) async {
    await FirebaseFirestore.instance.collection('contacts').doc(id).delete();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contact Successfully deleted")),
      );
    }
  }

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
                  leading: Hero(
                    tag: contactId,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditContactPage(
                                avatar: avatar,
                                name: name,
                                phone: phone,
                                email: email,
                                id: contactId,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(IconlyBroken.edit),
                        splashRadius: 24,
                      ),
                      IconButton(
                        onPressed: () {
                          deleteContact(contactId);
                        },
                        icon: const Icon(IconlyBroken.delete),
                        splashRadius: 24,
                      ),
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
