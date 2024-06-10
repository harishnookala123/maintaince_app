import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/styles.dart';

class CoRegistration extends StatefulWidget {
  const CoRegistration({super.key});

  @override
  State<CoRegistration> createState() => CoRegistrationState();
}

class CoRegistrationState extends State<CoRegistration> {
  var apartmentName = TextEditingController();
  var coAdmin = TextEditingController();
  var mobileNumber = TextEditingController();
  var emailId = TextEditingController();
  var password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BackGroundImage(
        child: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 2.4, bottom: 15.3),
            child: Text(
              "Co-Admin Registration",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.indigo,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                child: BasicText(
                  title: "Apartment Name : - ",
                  color: Colors.black,
                  fontSize: 15.5,
                ),
              ),
              Container(
                child: Textfield(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                child: BasicText(
                  title: "CoAdmin Name : - ",
                  color: Colors.black,
                  fontSize: 15.5,
                ),
              ),
              Container(
                child: Textfield(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                child: BasicText(
                  title: " Phone Number : - ",
                  color: Colors.black,
                  fontSize: 15.5,
                ),
              ),
              Container(
                child: Textfield(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                child: BasicText(
                  title: " Email : - ",
                  color: Colors.black,
                  fontSize: 15.5,
                ),
              ),
              Container(
                child: Textfield(
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                child: BasicText(
                  title: " Password : - ",
                  color: Colors.black,
                  fontSize: 15.5,
                ),
              ),
              Container(
                child: Textfield(
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
              ),
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
                onPressed: () {},
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ))
            ],
          ),
        ],
      ),
    ));
  }
}
