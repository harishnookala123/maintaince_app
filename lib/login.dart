import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/styles.dart';
import 'package:maintaince_app/userscreen.dart';

import 'mainScreen.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();

  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter  email';
    }
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter  email';
    }
    const String passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$';
    final RegExp regex = RegExp(passwordPattern);

    if (!regex.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter, lowercase letter, number, and special character';
    }

    return null; // Return null if the password is valid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackGroundImage(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(bottom: 15.3),
            child: BasicText(
              title: "Login Page",
              color: Colors.indigo.shade600,
              fontSize: 19,
            ),
          ),
          Container(
              margin: const EdgeInsets.all(12.3),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: email,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Email',
                        // labelText: 'Enter UserName',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: password,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Password',
                        // prefixIcon:  const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        var name = email.text;
                        if (formKey.currentState!.validate()) {
                          getPost(name, password.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserScreen(
                                        name: name,
                                      )));
                        }
                        // onPressed handler
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 37, vertical: 12),
                        elevation: 2.5, // Adjust padding as needed
                      ),
                      child: BasicText(
                        title: "Login",
                        color: Colors.indigo.shade600,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Don't You Have an Account?",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SelectRegister()));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 18.0,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.red.shade900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    ));
  }

  getPost(String name, String password) {
    var data = {"email": name, "password": password};
  }
}
