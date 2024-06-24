import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/coadminprovider.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:provider/provider.dart';

import '../../Admin/Views/adminscreen.dart';

class CoRegistration extends StatefulWidget {
  String? adminId;
  String? apartId;
  CoRegistration({super.key, this.adminId, this.apartId});

  @override
  State<CoRegistration> createState() => CoRegistrationState();
}

class CoRegistrationState extends State<CoRegistration> {
  var apartmentName = TextEditingController();
  var coAdmin = TextEditingController();
  var mobileNumber = TextEditingController();
  var emailId = TextEditingController();
  var password = TextEditingController();
  TextEditingController apartmentId = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? status;
  bool? messageId;

  bool? message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BackGroundImage(
          child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              child: Consumer<CoAdmin>(
                builder: (context, admin, child) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(bottom: 15.3),
                        child: Text(
                          "Co-Admin Registration",
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
                              margin:
                                  const EdgeInsets.only(left: 15.3, bottom: 8),
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
                              margin:
                                  const EdgeInsets.only(left: 15.3, bottom: 8),
                              child: BasicText(
                                title: "CoAdmin Name : - ",
                                color: Colors.black,
                                fontSize: 14.7,
                              ),
                            ),
                            Textfield(
                              text: "Enter coAdmin Name",
                              controller: coAdmin,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter CoAdmin Name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 15.3, bottom: 8),
                              child: BasicText(
                                title: " Phone Number : - ",
                                color: Colors.black,
                                fontSize: 14.7,
                              ),
                            ),
                            Textfield(
                              text: "Enter Phone Number",
                              controller: mobileNumber,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please mobileNumber";
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
                              margin:
                                  const EdgeInsets.only(left: 15.3, bottom: 8),
                              child: BasicText(
                                title: " Email : - ",
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
                              margin:
                                  const EdgeInsets.only(left: 15.3, bottom: 8),
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
                            status != null
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      status!.toString(),
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ))
                                : Container(),
                            const SizedBox(
                              height: 6,
                            ),
                            Center(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 4.0,
                                  backgroundColor: Colors.orange,
                                  minimumSize: const Size(160, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0))),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  getCoAdminRegistration(widget.adminId);
                                  if (status == "Co-Admin is registered") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdminScreen(
                                                  userid: widget.adminId,
                                                )));
                                  }
                                }
                              },
                              child: Text("Register",
                                  style: GoogleFonts.acme(
                                      fontSize: 20, color: Colors.white)),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              )),
        ));
  }

  getCoAdminRegistration(String? adminId) async {
    var headers = {'Content-Type': 'application/json'};
    print(apartmentName.text);
    var data = json.encode({
      "apartname": apartmentName.text,
      "name": coAdmin.text,
      "email": emailId.text,
      "phonenumber": mobileNumber.text,
      "password": password.text,
      "user_type": "Co-admin",
      "adminId": widget.adminId,
      "apartId": widget.apartId,
      "CoadminId": "Co${coAdmin.text}"
    });

    var dio = Dio();

    var response = await dio.request(
      'http://192.168.29.231:3000/Co-adminregister',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      setState(() {
        status = response.data["status"];
      });
      return status;
    } else {
      print("Har");
      print(response.statusMessage);
    }
  }
}
