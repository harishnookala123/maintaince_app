import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/Views/registration.dart';
import 'package:maintaince_app/User/Views/user_registration.dart';

import 'Co_admin/Views/registration.dart';

class SelectRegister extends StatefulWidget {
  const SelectRegister({super.key});

  @override
  SelectRegisterScreen createState() => SelectRegisterScreen();
}

class SelectRegisterScreen extends State<SelectRegister> {
  int selectedRadio = 0;
  final List<String> _options = ['Admin', 'User', 'Security'];

  void _handleRadioValueChange(int? value) {
    setState(() {
      selectedRadio = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Image.asset(
          'assets/Images/apartment.png', // Replace with your image URL
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        // Blurred effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            color: Colors.black.withOpacity(0.2),
            alignment: Alignment.center,
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Choose an Register option',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20.0),
                    ..._options.map((option) {
                      int index = _options.indexOf(option);
                      return RadioListTile<int>(
                        title: Text(option),
                        value: index,
                        groupValue: selectedRadio,
                        onChanged: _handleRadioValueChange,
                      );
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.4)),
                          minimumSize: const Size(150, 50),
                        ),
                        onPressed: () {
                          var value = _options[selectedRadio];
                          getNavigate(value);
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getNavigate(String value) {
    if (value == "Admin") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AdminRegistration()));
    }  else if (value == "User") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const UserRegistration()));
    } else if (value == "Security") {}
  }
}
