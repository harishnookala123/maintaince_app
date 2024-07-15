import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/apartmentdetails.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/User/Views/userscreen.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../../login.dart';

class UserSecondRegistration extends StatefulWidget {
  List<ApartmentDetails>? apartmentDetails;
   UserSecondRegistration({super.key, this.apartmentDetails});

  @override
  State<UserSecondRegistration> createState() => UserSecondRegistrationState();
}

class UserSecondRegistrationState extends State<UserSecondRegistration> {
  var apartmentName = TextEditingController();
  var apartmentId = TextEditingController();
  var apartId = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<String> usertype = ['Owner', 'Tenant'];
  String? selectedValue;
  String? status;
  bool? messageId;
  bool? message;

  String? blockNumber;
  // String? floorNumber;
  String? flatNum;

  final List<String> blockNumbers = ['A', 'B', 'C', 'D'];
  // final List<String> floorNumbers = ['1', '2', '3', '4'];
  final List<String> flatNumbers = ['101', '102', '103', '104'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackGroundImage(
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
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
              const SizedBox(height: 10),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Apartment Name
                    buildTextField(
                        "Apartment Name", apartmentName, TextInputType.text,
                        (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Apartment Name";
                      }
                      return null;
                    }),
                    const SizedBox(height: 8),
                    // User Details Section
                    buildUserDetailsSection(),
                    const SizedBox(height: 8),
                    // User Type Dropdown
                    buildDropdownButtonFormField("User Type", usertype,
                        (value) {
                      if (value == null) {
                        return 'Please select user Type.';
                      }
                      selectedValue = value;
                      return null;
                    }),
                    const SizedBox(height: 20),

                    // Submit Button
                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 4.0,
                                backgroundColor: Colors.orange,
                                minimumSize: const Size(160, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0))),
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  messageId == false) {
                                _registerUser();
                              } else {
                                message = false;
                              }
                            },
                            child: Text("Register",
                                style: GoogleFonts.acme(
                                    fontSize: 20, color: Colors.white)),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      TextInputType inputType, String? Function(String?)? validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.3, bottom: 8),
          child: BasicText(
            title: "$label : - ",
            color: Colors.black,
            fontSize: 14.7,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          validator: validator,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownButtonFormField(
      String label, List<String> items, String? Function(String?)? validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.3, bottom: 8),
          child: BasicText(
            title: "$label : - ",
            color: Colors.black,
            fontSize: 14.7,
          ),
        ),
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          hint: BasicText(
            title: 'Enter Usertype',
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          validator: validator,
          onChanged: (value) {
            selectedValue = value;
          },
        ),
      ],
    );
  }

  Widget buildUserDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15.3, bottom: 6),
          child: BasicText(
            title: "User Details : - ",
            color: Colors.black,
            fontSize: 14.7,
          ),
        ),
        const SizedBox(height: 10),
        buildDropdownButtonFormField("Block Number", blockNumbers,
            (value) => value == null ? 'Field required' : null),
        // const SizedBox(height: 16),
        // buildDropdownButtonFormField("Floor Number", floorNumbers,
        //     (value) => value == null ? 'Field required' : null),
        const SizedBox(height: 16),
        buildDropdownButtonFormField("Flat Number", flatNumbers,
            (value) => value == null ? 'Field required' : null),
      ],
    );
  }

  // void submitData() {
  //   // final String name = userName.text;
  //   final String apartment = apartmentName.text;
  //   final String block = blockNumber!;
  //   // final String floor = floorNumber!;
  //   final String flat = flatNum!;
  //
  //   final String type = selectedValue!;
  //
  //   // print('Name: $name');
  //   // print('Apartment: $apartment');
  //   // print('Block: $block');
  //   // print('Floor: $floor');
  //   // print('Flat: $flat');
  //   // print('Mobile: $mobile');
  //   // print('Email: $email');
  //   // print('Password: $passwordVal');
  //   //  print('Address: $address');print('Type: $type');
  // }

  _registerUser() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'apartmentName': apartmentName.text,
        'user_type': selectedValue,
        "apartId": apartmentId.text,
        // "userid": 'U${firstName.text}',
        "approval": "Pending"
      };

      final String jsonUserData = json.encode(userData);
      _sendDataToServer(jsonUserData);
    }
  }

  Future<void> _sendDataToServer(String jsonUserData) async {
    var headers = {'Content-Type': 'application/json'};
    print(jsonUserData);

    const String url =
        '$baseUrl/registerUser'; // Local server URL
    var dio = Dio();

    try {
      final response = await dio.request(url,
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: jsonUserData);

      if (response.statusCode == 200) {
        setState(() {
          status = response.data["status"];
        });
        if (status == "User is registered") {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Login(
                      // name: userName.text,
                      )));
        }
      } else {
        // Error
      }
    } catch (e) {
      print(e);
    }
  }

}
