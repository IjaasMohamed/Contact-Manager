import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_manager/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({
    Key? key,
    required this.avatar,
    required this.email,
    required this.name,
    required this.phone
    }) : super(key: key);
  
  final String avatar;
  final String name;
  final String phone;
  final String email;
  
  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController ;
  late final TextEditingController phoneController ;
  late final TextEditingController emailController ;
  
  void editContact() async{}

  @override
  void initState() {
    nameController = TextEditingController(
      text: widget.name,
    );
    phoneController = TextEditingController(
      text: widget.phone,
    );
    emailController = TextEditingController(
      text: widget.email,
    );
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Name",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a phone number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "phone",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Email",
                    contentPadding: inputPadding,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                        onPressed: editContact,
                        icon: const Icon(IconlyBroken.add_user),
                        label: const Text("Add Contact")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
