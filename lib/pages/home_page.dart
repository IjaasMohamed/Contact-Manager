import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Contacts"),
      ),
      body: const Center(
        child: Text(
          "Mock Contact List",
          style: TextStyle(fontSize: 18.0),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Mock action for adding a contact
          print("Add Contact Pressed");
        },
        label: const Text("Add Contact"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
