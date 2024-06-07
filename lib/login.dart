import 'package:flutter/material.dart';
import 'package:maintaince_app/userscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {

  var email = TextEditingController();
  var password = TextEditingController();
  var formkey = GlobalKey<FormState>();

  String?validateEmail(String? value){
    if(value==null || value.isEmpty){
      return'Please enter  email';
    }
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(emailPattern);
    if(!regex.hasMatch(value)){
      return 'Enter a valid email address';
    }
    return null;
  }
  String? validatePassword(String? value){
    if(value==null || value.isEmpty){
      return'Please enter  email';
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
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          'Login Page',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
          margin: const EdgeInsets.all(12.3),
          child:Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: email,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Password',
                    // prefixIcon:  const Icon(Icons.lock),


                  ),

                ),
                const SizedBox(
                  height: 25,
                ),

                ElevatedButton(
                  onPressed: () {

                    var name = email.text;

                    if(formkey.currentState!.validate()){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserScreen(name:name,)));
                    }

                    // onPressed handler
                  },

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    elevation: 5,// Adjust padding as needed
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
