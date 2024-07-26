import 'dart:ui';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/userregistration.dart';
import 'package:provider/provider.dart';

import '../Admin/changeprovider/adminprovider.dart';

class BasicText extends StatelessWidget {
  String? title;
  Color? color;
  double? fontSize;

  BasicText({super.key, this.color, this.title, this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: GoogleFonts.robotoSerif(
          color: color,
          letterSpacing: 0.5,
          fontSize: fontSize,
          fontWeight: FontWeight.w400),
    );
  }
}

class Textfield extends StatelessWidget {
  TextEditingController? controller;
  String? text;
  TextInputType? keyboardType;
  int? maxlines;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  Textfield(
      {super.key,
      this.text,
      this.controller,
      this.keyboardType,
      this.maxlines,
      this.validator,
      this.onChanged});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        textCapitalization: TextCapitalization.none,
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        maxLines: maxlines,
        validator: validator,
        decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(fontSize: 13.9),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 22.0, horizontal: 15.0),
            fillColor: Colors.pink,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.3),
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: const OutlineInputBorder()));
  }
}

class BackGroundImage extends StatelessWidget {
  Widget? child;
  BackGroundImage({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/Images/apartment.png', // Replace with your image URL
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.05,
              child: Card(
                //color: Colors.white.withOpacity(0.9),
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}

class Blocks extends StatelessWidget{
  TextEditingController? noOfFloors = TextEditingController();
  TextEditingController? blockname = TextEditingController();
  Blocks({super.key, this.noOfFloors,this.blockname});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(height: 20,),
        Textfield(
          controller: noOfFloors,
          text: "Enter no of Floors",
          keyboardType: TextInputType.number,
          validator: (value){
            if(value!.isNotEmpty){
              return "please enter no of blocks";
            }
            return null;
          },
        )
      ],
    );
  }

}


class CommonTextField extends StatelessWidget {
  TextEditingController? firstName = TextEditingController();
  TextEditingController? lastName = TextEditingController();
  TextEditingController? phone = TextEditingController();
  TextEditingController? email = TextEditingController();
  TextEditingController? password = TextEditingController();
  TextEditingController? address = TextEditingController();
  CommonTextField ({super.key,
    this.firstName,this.lastName,this.phone,this.email,this.password,this.address
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Consumer<AdminRegistrationModel>(
    builder: (context, registration, child){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15.3),
            child: BasicText(
              title: "First Name : - ",
              color: Colors.black,
              fontSize: 15.5,
            ),
          ),
          const SizedBox(height: 5),
          Textfield(
            controller: firstName,
            text: 'Enter First Name',
            keyboardType: TextInputType.text,
            onChanged: (value){
              registration.setfirstname(value);
            },
            validator: (value){
              if(value!.isEmpty){
                return "Please Enter First_Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 15.3),
            child: BasicText(
              title: "Last Name : - ",
              color: Colors.black,
              fontSize: 15.5,
            ),
          ),
          const SizedBox(height: 5),
          Textfield(
            keyboardType: TextInputType.text,
            controller: lastName,
            text: "Enter Your Last_Name",
            onChanged: (value) {
                registration.setlastname(value);
            },
            validator: (value){
              if(value!.isEmpty){
                return "Please Enter Last_Name";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 15.3),
            child: BasicText(
              title: "Email : - ",
              color: Colors.black,
              fontSize: 15.5,
            ),
          ),
          const SizedBox(height: 5),
          Textfield(
            keyboardType: TextInputType.text,
            controller: email,
            text: "Enter email",
            onChanged: (value) {
              registration.setEmail(value);
            },
            validator: (value){
              if(value!.isEmpty){
                return "Please Enter Email address";
              }
              if(value.isNotEmpty){
                final bool isValid = EmailValidator.validate(email!.text);
                if(isValid==false){
                  return "Please Enter valid Email address";
                }
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 15.3),
            child: BasicText(
              title: "Phone number : - ",
              color: Colors.black,
              fontSize: 15.5,
            ),
          ),
          const SizedBox(height: 5),
          Textfield(
            keyboardType: TextInputType.number,
            controller: phone,
            text: "Enter Phone number",
            onChanged: (value) {
              registration.setPhone(value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter phone number";
              }
              if (value.length != 10) {
                return "Enter Valid Phone number";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.only(left: 15.3),
            child: BasicText(
              title: "Password : - ",
              color: Colors.black,
              fontSize: 15.5,
            ),
          ),
          const SizedBox(height: 5),
          Textfield(
            keyboardType: TextInputType.text,
            controller: password,
            text: "Enter Password",
            onChanged: (value) {
              registration.setPassword(value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Password";
              }
              const passwordPattern =
                  r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$';
              final regex = RegExp(passwordPattern);
              if (!regex.hasMatch(value)) {
                return 'capital letter, number, special character, 8 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 10,)

        ],
      );


    }),
    );
  }
}

