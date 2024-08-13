import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'dart:convert';

import '../../Admin/Model/usermodel.dart';

class EditProfileScreen extends StatefulWidget {
  final Users user;

  EditProfileScreen({required this.user});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String phone;

  @override
  void initState() {
    super.initState();
    firstName = widget.user.first_name ?? '';
    lastName = widget.user.last_name ?? '';
    phone = widget.user.phone ?? '';
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var data = {

        "first_name": firstName,
        "last_name" : lastName,
        "phone": phone
      };
      var value = ApiService().editprofile(data,widget.user.uid);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: firstName,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onSaved: (value) => firstName = value!,
              ),
              TextFormField(
                initialValue: lastName,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
                onSaved: (value) => lastName = value!,
              ),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) => phone = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
