import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/User/Views/userscreen.dart';
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
  var apartmentId = TextEditingController();
  var apartId = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<String> usertype = [
    'Owner',
    'Tenant',
  ];
  String? selectedValue;
  String? status;
  bool? messageId;
  bool? message;
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
                            title: "UserName : - ",
                            color: Colors.black,
                            fontSize: 14.7,
                          ),
                        ),
                        Textfield(
                          text: "UserName",
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
                        BasicText(
                          title: "User type : -",
                          color: Colors.black,
                          fontSize: 14.7,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            // Add Horizontal padding using menuItemStyleData.padding so it matches
                            // the menu padding when button's width is not specified.
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            // Add more decoration..
                          ),
                          hint: const Text(
                            'Select Your User type',
                            style: TextStyle(fontSize: 14),
                          ),
                          items: usertype
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
                          validator: (value) {
                            if (value == null) {
                              return 'Please select user Type.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            selectedValue = value.toString();
                            //Do something when selected item is changed.
                          },
                          onSaved: (value) {
                            selectedValue = value.toString();
                          },
                          buttonStyleData: const ButtonStyleData(
                            padding: EdgeInsets.only(right: 8),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 24,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 15.3),
                          child: BasicText(
                            title: "Apartment Id (ex: SSA123)",
                            fontSize: 15.5,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 12.4),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.8,
                                    child: Textfield(
                                      controller: apartmentId,
                                      text: "Apartment Id",
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ),
                                messageId == false
                                    ? const Row(
                                  children: [
                                    Icon(
                                      Icons.verified_user_rounded,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    Text(
                                      "Verified",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 16),
                                    )
                                  ],
                                )
                                    : Expanded(
                                  child: SizedBox(
                                    width: 280,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          Colors.green.shade500),
                                      onPressed: () async {
                                        await getVerify();
                                      },
                                      child: const Text(
                                        "Verify",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        message == false
                            ? Container(
                          margin: const EdgeInsets.only(top: 5.3),
                          child: messageId == false
                              ?  Container()
                              : Container(
                            child: const Text("ApartmentId is not Present ",
                             style: TextStyle(color: Colors.red),
                            ),
                          ),
                        )
                            : Container(
                          margin: const EdgeInsets.only(top: 3.4),
                          child: Text(
                            message == true
                                ? "Id should be atleast 4 charcters and minimum "
                                "One number & "
                                "One alphabet"
                                : "",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 11.5),
                          ),
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
                          keyboardType: TextInputType.multiline,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Address";
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
                          onPressed: ()  {
                            if (formKey.currentState!.validate()&& messageId==false) {
                                _registerUser();
                            }else{
                              message = false;
                            }
                          },
                          child: Text("Register",
                              style: GoogleFonts.acme(
                                  fontSize: 20, color: Colors.white)),
                        )),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }

  _registerUser() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> userData = {
        'appart_name': apartmentName.text,
        'user_name': userName.text,
        'flat_no': flatNumber.text,
        'mobile_num': mobileNumber.text,
        'email_id': emailId.text,
        'password': password.text,
        'user_type': selectedValue,
        "apartId": apartmentId.text,
        "userid": 'U${userName.text}',
        'permenant_address': permanentAddress.text,
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
        'http://192.168.29.231:3000/registerUser'; // Local server URL
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => UserScreen(
                        name: userName.text,
                      )));
        }
      } else {
        // Error
      }
    } catch (e) {
        print(e);
     }
  }

  getVerify() async {
    const pattern = r'^(?=.*[a-zA-Z])(?=.*\d)(?=(?:[^a-zA-Z]*[a-zA-Z])).{1,}$';
    final regExp = RegExp(pattern);
    if (regExp.hasMatch(apartmentId.text)) {
      await postAdminId(apartmentId.text);
      setState(() {
        message = false;
      });
    } else if (!regExp.hasMatch(apartmentId.text)) {
      setState(() {
        message = true;
      });
    }
  }

  postAdminId(String apartId) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"adminId": apartId});
    var dio = Dio();
    var response = await dio.request(
      'http://192.168.29.231:3000/checkAdminId',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      setState(() {
        messageId = response.data["message"];
      });
    }
  }
}
