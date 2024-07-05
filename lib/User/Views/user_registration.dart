import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/blocks.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/User/Views/user_registrationseccondscreen.dart';
import 'package:maintaince_app/User/Views/userscreen.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../Admin/Model/apartmentdetails.dart';

class UserRegistration extends StatefulWidget {
  List<String>? blocknames;
  List<ApartmentDetails>? apartmentDetails;
  String? apartmentcode;

  UserRegistration({super.key, this.blocknames, this.apartmentDetails, this.apartmentcode});

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

  var selectedValue;
  String? selectedflat;

  @override
  Widget build(BuildContext context) {
    print(widget.apartmentcode);
    return Scaffold(
      body: BackGroundImage(
        child: Consumer<AdminRegistrationModel>(
          builder: (context, registration, child) {
            return SizedBox(
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
                          ),
                          hint: const Text(
                            'Select Your Gender',
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
                                  const SizedBox(height: 20),
                                  Center(
                                    child: ElevatedButton(
                                        onPressed: (){},
                                     style: ElevatedButton.styleFrom(
                                       minimumSize: const Size(130, 50),
                                       backgroundColor: Colors.orangeAccent.shade400
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
          print(selectedflat);
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
}
