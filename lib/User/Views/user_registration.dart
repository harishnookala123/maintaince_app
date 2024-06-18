import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/styles/basicstyles.dart';


class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => UserRegistrationState();
}

class UserRegistrationState extends State<UserRegistration> {
  var apartmentName = TextEditingController();
  var userName = TextEditingController();
  var flatNumber = TextEditingController();
  var mobileNumber = TextEditingController();
  var emailId = TextEditingController();
  var password = TextEditingController();
  var permanentAddress = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  Future<void> _sendDataToServer(String jsonUserData) async {
    const String url = 'http://192.168.29.92:3000/newuserdata'; // Local server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonUserData,
      );

      if (response.statusCode == 200) {
        // Successfully registered
        print('User registered successfully.');
      } else {
        // Error
        print('Error registering user: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _registerUser() {
    if (formKey.currentState!.validate()) {

      Map<String,dynamic> userData = {
        'appart_name': apartmentName.text,
        'user_name': userName.text,
        'flat_no': flatNumber.text,
        'mobile_num': mobileNumber.text,
        'email_id': emailId.text,
        'password': password.text,
        'user_type': "user",
        'permenant_address': permanentAddress.text,
      };
      final String jsonUserData = jsonEncode(userData);
      _sendDataToServer(jsonUserData);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BackGroundImage(
         child: Container(
             height: MediaQuery.of(context).size.height /1.3,
             child: ListView(
               padding: EdgeInsets.zero,
               scrollDirection: Axis.vertical,
               physics: const ScrollPhysics(),
               shrinkWrap: true,
               //mainAxisSize: MainAxisSize.min,
               children: [
                 Container(
                   alignment: Alignment.topCenter,
                   margin: const EdgeInsets.only(bottom: 15.3),
                   child: Text(
                     "User Registration",
                     style: GoogleFonts.poppins(
                       fontSize: 16,
                       color: Colors.indigo,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),
                 const SizedBox(
                   height: 10,
                 ),
                 Form(
                   key: formKey,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                         child: BasicText(
                           title: "Apartment Name : - ",
                           color: Colors.black,
                           fontSize: 14.7,
                         ),
                       ),
                       Textfield(
                         text: "ApartmentName",
                         controller: apartmentName,
                         keyboardType: TextInputType.text,
                         validator: (value) {
                           if (value!.isEmpty) {
                             return "Please Enter Apartment Name";
                           }
                           return null;
                         },
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Container(
                         margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                         child: BasicText(
                           title: "userName : - ",
                           color: Colors.black,
                           fontSize: 14.7,
                         ),
                       ),
                       Textfield(
                         text: "userName",
                         controller: userName,
                         keyboardType: TextInputType.text,
                         validator: (value) {
                           if (value!.isEmpty) {
                             return "Please Enter User_Name";
                           }
                           return null;
                         },
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Container(
                         margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                         child: BasicText(
                           title: "Flat_No : - ",
                           color: Colors.black,
                           fontSize: 14.7,
                         ),
                       ),
                       Textfield(
                         text: "Flat_No",
                         controller: flatNumber,
                         keyboardType: TextInputType.text,
                         validator: (value) {
                           if (value!.isEmpty) {
                             return "Please Enter User_Name";
                           }
                           return null;
                         },
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Container(
                         margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                         child: BasicText(
                           title: " Mobile_number : - ",
                           color: Colors.black,
                           fontSize: 14.7,
                         ),
                       ),
                       Textfield(
                         text: "Mobile_Number",
                         controller: mobileNumber,
                         keyboardType: TextInputType.phone,
                         validator: (value) {
                           if (value!.isEmpty) {
                             return "Please Enter Flat_Number";
                           }
                           if (value.length != 10) {
                             return "Valid Mobile Number";
                           }
                           return null;
                         },
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Container(
                         margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                         child: BasicText(
                           title: " Enter Email : - ",
                           color: Colors.black,
                           fontSize: 14.7,
                         ),
                       ),
                       Textfield(
                         text: "Enter Email",
                         controller: emailId,
                         keyboardType: TextInputType.text,
                         validator: (value) {
                           if (value!.isEmpty) {
                             return "Please Enter Email";
                           }
                           const String emailPattern =
                               r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                           final RegExp regex = RegExp(emailPattern);
                           if (!regex.hasMatch(value)) {
                             return 'Enter a valid email address';
                           }
                           return null;
                         },
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Container(
                         margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                         child: BasicText(
                           title: " Password : - ",
                           color: Colors.black,
                           fontSize: 14.7,
                         ),
                       ),
                       Textfield(
                         text: "Enter Password",
                         controller: password,
                         keyboardType: TextInputType.text,
                         validator: (value) {
                           if (value!.isEmpty) {
                             return "Please Enter password";
                           }
                           const String passwordPattern =
                               r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$';
                           final RegExp regex = RegExp(passwordPattern);

                           if (!regex.hasMatch(value)) {
                             return 'Password must be at least 8 characters long, include an uppercase letter, lowercase letter, number, and special character';
                           }
                           return null;
                         },
                       ),
                       const SizedBox(
                         height: 10,
                       ),
                       Container(
                         margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                         child: BasicText(
                           title: "Address : - ",
                           color: Colors.black,
                           fontSize: 14.7,
                         ),
                       ),
                       Textfield(
                         text: "Address",
                         controller: permanentAddress,
                         keyboardType: TextInputType.text,
                         validator: (value) {
                           if (value!.isEmpty) {
                             return "Please Enter Address";
                           }
                           return null;
                         },),
                       const SizedBox(
                         height: 10,
                       ),
                       Center(
                           child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                 elevation: 4.0,
                                 backgroundColor: Colors.orange,
                                 minimumSize: const Size(160, 50),
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(25.0))),
                             onPressed: () {
                               if (formKey.currentState!.validate()) {
                                 _registerUser();
                               }
                             },
                             child: Text("Register",
                                 style: GoogleFonts.acme(
                                     fontSize: 20, color: Colors.white)),
                           ))
                     ],
                   ),
                 )
               ],
             ))
        ),
    );


  }



}
