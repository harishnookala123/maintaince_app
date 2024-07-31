import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/adminRegistartion.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:provider/provider.dart';

import '../../Admin/Model/coadmin.dart';
import '../../Admin/Views/adminscreen.dart';
import '../../Admin/Views/homepage.dart';
import '../../Admin/changeprovider/api.dart';

class CoRegistration extends StatefulWidget {
  String? adminId;
  String? apartId;
  Admin? admin;
  CoRegistration({super.key, this.adminId, this.apartId, this.admin });

  @override
  State<CoRegistration> createState() => CoRegistrationState();
}

class CoRegistrationState extends State<CoRegistration> {
  var apartCode = TextEditingController();
  var fisrtName = TextEditingController();
  var lastName = TextEditingController();
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
              child:ListView(
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
                                title: "First Name : - ",
                                color: Colors.black,
                                fontSize: 14.7,
                              ),
                            ),
                            Textfield(
                              text: "Enter First Name",
                              controller: fisrtName,
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
                                title: "Last Name : - ",
                                color: Colors.black,
                                fontSize: 14.7,
                              ),
                            ),
                            Textfield(
                              text: "Enter Last Name",
                              controller: lastName,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Enter Last Name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(bottom: 3.4),
                              child: BasicText(title: "Enter Apartment Code"),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.8,
                                    child: Textfield(
                                      controller: apartmentId,
                                      text: "Apartment Id",
                                      keyboardType: TextInputType.text,
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Please Enter Apartment Code";
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                        /*  apartmentId.value = apartmentId.value.copyWith(
                                  text: value.replaceAll(' ', ''),
                                  selection: TextSelection.collapsed(offset: value.length),
                                );*/

                                      },
                                    ),
                                  ),
                                  messageId == false
                                      ? const SizedBox(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.verified_user_rounded,
                                          color: Colors.green,
                                          size: 25,
                                        ),
                                        Text(
                                          "Verified",
                                          style: TextStyle(
                                              color: Colors.green, fontSize: 14),
                                        )
                                      ],
                                    ),
                                  )
                                      : Expanded(
                                    child: SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height / 16.3,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 6),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              Colors.green.shade500),
                                          onPressed: () async {
                                            await getVerify();
                                            if(messageId==false){
                                              var apartmentDetails = await ApiService().getApartmentDetails(apartmentId.text);
                                              print(apartmentDetails);
                                            }
                                          },
                                          child: const Text(
                                            "Verify",
                                            style: TextStyle(
                                                fontSize: 17, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (message == false)
                              Container(
                                margin: const EdgeInsets.only(top: 5.3),
                                child: messageId == true
                                    ? const Text(
                                  "Apartment Id already Present",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 14.5),
                                )
                                    : Container(),
                              )
                            else
                              Container(
                                margin: const EdgeInsets.only(top: 3.4),
                                child: Text(
                                  messageId == true
                                      ? "Id should be at least 4 characters and contain at least one number and one alphabet"
                                      : "",
                                  style:
                                  const TextStyle(color: Colors.red, fontSize: 11.5),
                                ),
                              ),
                            const SizedBox(
                              height: 10,
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
                                  setState(() {
                                    getCoAdminRegistration(widget.adminId);
                                  });
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
              )),
        ));
  }

  getCoAdminRegistration(String? adminId) async {
    print(widget.apartId);
    var headers = {'Content-Type': 'application/json'};
    // print(apartmentName.text);
    var data = json.encode({
      "first_name": fisrtName.text,
      "last_name": lastName.text,
      "email": emailId.text,
      "phone": mobileNumber.text,
      "password": password.text,
      "user_type": "Co-admin",
      "admin_id": widget.adminId,
      "apartment_code": apartmentId.text,
      "CoadminId": "Co${fisrtName.text}"
    });

    var dio = Dio();

    var response = await dio.request(
      '$baseUrl/coadmin',
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
      if(status=="Coadmin is registered"){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                  userid: widget.adminId,
                  admin: widget.admin,
                )));
      }
    } else {
      print("Har");
      print(response.statusMessage);
    }
  }


  Future<void> getVerify() async {
    const pattern = r'^(?=.*[a-zA-Z])(?=.*\d)(?=(?:[^a-zA-Z]*[a-zA-Z])).{1,}$';
    final regExp = RegExp(pattern);
    if (regExp.hasMatch(apartmentId.text)) {
      await postAdminId(apartmentId.text);
      setState(() {
        message = false;
      });
    } else {
      setState(() {
        message = true;
      });
    }
  }

  Future<void> postAdminId(String apartmentCode) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"apartment_code": apartmentCode});
    var dio = Dio();
    var response = await dio.get(
      '$baseUrl/checkAdminId/$apartmentCode',
      options: Options(headers: headers),
      data: data,
    );
    if (response.statusCode == 200) {
      setState(() {
        messageId = response.data["message"];
        var adminId = response.data["admin_id"];
      });
    }
  }
}
