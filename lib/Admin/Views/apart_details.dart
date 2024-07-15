import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:provider/provider.dart';

import '../changeprovider/apartmentdetails.dart';
import 'blocknames.dart';

class ApartmentDetails extends StatefulWidget {
  final String? userid;
  AdminRegistrationModel? registration;
  ApartmentDetails({super.key, this.userid, this.registration});

  @override
  ApartmentDetailsState createState() => ApartmentDetailsState();
}

class ApartmentDetailsState extends State<ApartmentDetails> {
  final TextEditingController apartname = TextEditingController();
  final TextEditingController noofblocks = TextEditingController();
  final TextEditingController apartmentcode = TextEditingController();
  final TextEditingController address = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<Map<String, dynamic>> _textFieldControllers = [];
  final TextEditingController blockname = TextEditingController();

  int? blocks;
  bool pressed = false;

  bool? messageId;

  bool? message;

  var status;

  var apartmentCode;

  @override
  void initState() {
    super.initState();
    _addNewTextFields(); // Add initial text fields
  }

  void _addNewTextFields() {
    setState(() {
      _textFieldControllers.add({
        'from': TextEditingController(),
        'to': TextEditingController(),
        'isAddButton': true, // Initially, the button is the "+" button
      });
    });
  }

  void _toggleButton(int index) {
    setState(() {
      _textFieldControllers[index]['isAddButton'] = false; // Change "+" to "-"
      _addNewTextFields(); // Add a new row of text fields
    });
  }

  void _removeTextFields(int index) {
    setState(() {
      _textFieldControllers[index]['from']?.dispose();
      _textFieldControllers[index]['to']?.dispose();
      _textFieldControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    // Dispose of all the controllers when the widget is disposed
    for (var controllers in _textFieldControllers) {
      controllers['from']?.dispose();
      controllers['to']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent.shade200,
          centerTitle: true,
          title: BasicText(
            color: Colors.white,
            title: "Apartment Details",
            fontSize: 16.5,
          ),
        ),
        body: Consumer<ApartDetails>(builder: (context, apartment, child) {
          return Consumer<AdminRegistrationModel>(
            builder: (context, registration, child) {
              return Container(
                margin: const EdgeInsets.all(12.3),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            //width: MediaQuery.of(context).size.width / 1.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BasicText(
                                  title: "Enter apartment name",
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: Textfield(
                                    controller: apartname,
                                    keyboardType: TextInputType.text,
                                    text: "Enter apartment name",
                                    onChanged: (value) {
                                      apartment.setApartname(value);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter apartname";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                BasicText(
                                  title: "Enter no of Blocks",
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                const SizedBox(height: 7),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.3,
                                  child: Textfield(
                                    controller: noofblocks,
                                    keyboardType: TextInputType.number,
                                    text: "Enter no of Blocks",
                                    onChanged: (value) {
                                      apartment.setBlocks(int.parse(value));
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter blocks";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 7,),
                                BasicText(
                                  title: "Address",
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                const SizedBox(height: 7,),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width / 1.3,
                                  //height: MediaQuery.of(context).size.height,
                                  child: Textfield(
                                    controller: address,
                                    keyboardType: TextInputType.multiline,
                                    maxlines: null,
                                    text: "Enter address",
                                    onChanged: (value) {
                                      apartment.setaddress(value);
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Address";
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BasicText(
                            title: "Set Apartment Code (Ex : SS123) ",
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.6,
                                child: Textfield(
                                  controller: apartmentcode,
                                  keyboardType: TextInputType.text,
                                  text: "Set Apartment Code",
                                  onChanged: (value) {
                                    setState(() {
                                      apartment.setApartmentCode(value);
                                    });
                                  },
                                ),
                              ),
                              messageId == true
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
                                                color: Colors.green,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    )
                                  : Expanded(
                                      child: SizedBox(
                                        // width: 280,
                                        // height: 50,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                16.3,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 6),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.orange.shade500),
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
                                    ),
                            ],
                          ),
                          message == false
                              ? Container(
                                  margin: const EdgeInsets.only(top: 5.3),
                                  child: messageId == false
                                      ? const Text(
                                          "Apartment Id already Present ",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 14.5),
                                        )
                                      : Container(),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(top: 3.4),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      message == true
                                          ? "Id should be atleast 4 charcters and minimum "
                                              "One number & "
                                              "One alphabet"
                                          : "",
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 11.5),
                                    ),
                                  )),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 3.0,
                                minimumSize: const Size(120, 50),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                   postAdminDetails(registration,apartment);
                                }
                              },
                              child: BasicText(
                                title: "Continue",
                                fontSize: 17,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }));
  }

  getVerify() async {
    const pattern = r'^(?=.*[a-zA-Z])(?=.*\d)(?=(?:[^a-zA-Z]*[a-zA-Z])).{1,}$';
    final regExp = RegExp(pattern);
    if (regExp.hasMatch(apartmentcode.text)) {
      await postAdminId(apartmentcode.text);
      setState(() {
        message = false;
      });
    } else if (!regExp.hasMatch(apartmentcode.text)) {
      setState(() {
        message = true;
      });
    }
  }

  postAdminId(String apartmentcode) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"apartmentcode": apartmentcode});
    var dio = Dio();
    var response = await dio.request(
      'http://192.168.29.231:3000/checkAdminId/$apartmentcode',
      options: Options(
        method: 'GET',
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

   postAdminDetails(AdminRegistrationModel registration, ApartDetails apartment) async {
    print(widget.userid);
     var headers = {'Content-Type': 'application/json'};
     var data = json.encode({
       "admin_id": widget.userid,
       "first_name": registration.firstname,
       "last_name" : registration.lastname,
       "apartment_code":apartmentcode.text,
       "apartment_name":apartname.text,
       "email": registration.email,
       "phone": registration.phone,
       "admin_type": "admin",
       "address": address.text,
     });
     var dio = Dio();

     var response = await dio.request(
       'http://192.168.29.231:3000/regapartAdmin',
       options: Options(
         method: 'POST',
         headers: headers,
       ),
       data: data,
     );
     if(response.statusCode==200){
       print(response.data);
       status = response.data["status"];
       apartmentCode = response.data["apartCode"];
       if(status=="Admin details entered"){
       Navigator.of(context).push(MaterialPageRoute(
           builder: (context) => BlockName(
             noOfblocks: noofblocks.text,
             apartname: apartname.text,
           )));
       }
     }
   }
}
