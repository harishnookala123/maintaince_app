import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/User/Views/user_registrationseccondscreen.dart';
import 'package:maintaince_app/User/Views/userscreen.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../Admin/Model/apartmentdetails.dart';
import '../../login.dart';

class UserRegistration extends StatefulWidget {
  List<String>? blocknames;
  List<ApartmentDetails>? apartmentDetails;
  String? apartmentcode;
  String?adminId;
  UserRegistration({super.key, this.blocknames, this.apartmentDetails,this.apartmentcode,this.adminId});

  @override
  State<UserRegistration> createState() => UserRegistrationState();
}

class UserRegistrationState extends State<UserRegistration> {
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var phone = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var address = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController apartmentId = TextEditingController();
  String? status;
  bool? messageId;
  bool? message;
  List<String>? blocknames = [];
  bool? flag;
 var usertype;
  var selectedValue;
  String? selectedflat;
 List user_type = ["Owner","Tenant"];
  @override
  Widget build(BuildContext context) {
    print(widget.apartmentDetails);
    return Scaffold(
      body: BackGroundImage(
        child: Consumer<AdminRegistrationModel>(
          builder: (context, registration, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height/1.4,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
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
                        const SizedBox(height: 8),
                        CommonTextField(
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          password: password,
                          phone: phone,
                        ),
                        BasicText(
                          title: "Select block name",
                          fontSize: 15.5,
                        ),
                        DropdownButtonFormField2<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            enabled: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 18),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15.4),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.4)
                            )
                          ),
                          hint: const Text(
                            'Select Your Block',
                            style: TextStyle(fontSize: 14),
                          ),
                          items: widget.blocknames!
                              .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                               item.toUpperCase(),
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ))
                              .toList(),
                          validator: (value) {
                            if (value == null) {
                              return 'Please select block.';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value.toString();
                              selectedflat = null; // Reset the selected flat value
                            });
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
                              color: Colors.black,
                            ),
                            iconSize: 25,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            elevation: 12,
                            maxHeight: MediaQuery.of(context).size.height/2.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const SizedBox(height: 5),
                        FutureBuilder<List<String>?>(
                          future: ApiService().getFlats(widget.apartmentcode, selectedValue),
                          builder: (context, snap) {
                            if (snap.hasData) {
                              List<String> flatno = snap.data!;
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BasicText(
                                    title: "Select Flat",
                                    fontSize: 15.5,
                                    color: Colors.black,
                                  ),
                                  Container(
                                    child: getDropdown(flatno),
                                  ),
                                  const SizedBox(height: 8,),
                                  BasicText(
                                    title: "Select User Type",
                                    fontSize: 15.5,
                                  ),
                                  const SizedBox(height: 7),
                                  DropdownButtonFormField2<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        enabled: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 18),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.circular(15.4),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.4)
                                        )
                                    ),
                                    hint: const Text(
                                      'Select Your user type',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    items: user_type
                                        .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select block.';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        usertype = value.toString();
                                        // Reset the selected flat value
                                      });
                                    },
                                    onSaved: (value) {
                                      usertype = value.toString();
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding: EdgeInsets.only(right: 8),
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      iconSize: 25,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      elevation: 12,
                                      maxHeight: MediaQuery.of(context).size.height/2.7,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      padding: EdgeInsets.symmetric(horizontal: 25),
                                    ),
                                  ),
                                  const SizedBox(height: 15,),
                                  Center(
                                    child: ElevatedButton(
                                        onPressed: (){
                                          getNavigate(selectedValue,
                                              selectedflat,widget.apartmentDetails,
                                              usertype
                                          );
                                        },
                                     style: ElevatedButton.styleFrom(
                                       minimumSize: const Size(130, 50),
                                       backgroundColor: Colors.orangeAccent.shade700
                                     ),
                                        child:  Text("Register",
                                         style: GoogleFonts.poppins(
                                           color: Colors.white,
                                           fontSize: 18,
                                           fontWeight: FontWeight.w600
                                         )
                                        ),
                                    ),
                                  )
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  getDropdown(List<String> flatno) {
    return DropdownButtonFormField2<String>(
      isDense: true,
      isExpanded: true,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 22),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(15.4),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.4)
        ),
      ),
      hint: const Text(
        'Select Your Flat no',
        style: TextStyle(fontSize: 14),
      ),
      value: selectedflat, // Use the selected flat value
      items: flatno
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item.toString(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.w400,
           fontSize: 18
          ),
        ),
      ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select block.';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedflat = value.toString();
        });
      },
      onSaved: (value) {
        selectedflat = value.toString();
        print(selectedflat);
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        iconSize: 25,
      ),
      dropdownStyleData: DropdownStyleData(
        elevation: 12,
        maxHeight: MediaQuery.of(context).size.height/2.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 25),
      ),
    );
  }

   getNavigate(selectedValue, String? selectedflat,
      List<ApartmentDetails>? apartmentDetails, usertype) async {
    print(widget.adminId);
     var apartname = apartmentDetails![0].apartmentName;
     var address = apartmentDetails[0].address;
     Map<String,dynamic> userData = {
     "uid" : "U${firstName.text}",
     "first_name" : firstName.text,
     "last_name" : lastName.text,
       "password": password.text,
       "apartment_name": apartname,
       "apartment_code" : widget.apartmentcode,
       "address" : address,
       "email" : email.text,
       "phone": phone.text,
       "block_name": selectedValue.toString(),
       "flat_no" : selectedflat,
       "user_type": usertype,
       "admin_id":widget.adminId,
       "status":"Pending",
       "remarks":"",
     };
     print(widget.adminId);
     final String jsonUserData = json.encode(userData);
    var values = await ApiService().registerUser(userData);
    if(values!=null){
      print(values.user_type);
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
      const Login()));
    }
   }
}
