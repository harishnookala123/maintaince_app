import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import '../../styles.dart';
import '../Model/adminRegistartion.dart';
import 'homepage.dart';

class AdminPersonal extends StatefulWidget {
  const AdminPersonal({super.key});
  @override
  State<AdminPersonal> createState() => _AdminPersonalState();
}

class _AdminPersonalState extends State<AdminPersonal> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> personalKey = GlobalKey<FormState>();
  String? status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Image.asset(
            'assets/Images/apartment.png', // Replace with your image URL
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
                color: Colors.black.withOpacity(0.2),
                child: Consumer<AdminRegistrationModel>(
                    builder: (context, registration, child) {
                  return Center(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.05,
                        child: Card(
                          elevation: 12.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 2.4, bottom: 15.3),
                                    child: Text(
                                      "Personal Details",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  buildForm(registration)
                                ]),
                          ),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }

  buildForm(AdminRegistrationModel registration) {
    return Form(
      key: personalKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(3.3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15.3),
                  child: BasicText(
                    title: "Admin Name : - ",
                    color: Colors.black,
                    fontSize: 15.5,
                  ),
                ),
                const SizedBox(height: 10),
                Textfield(
                  keyboardType: TextInputType.text,
                  controller: name,
                  text: "Enter Your Name",
                  onChanged: (value) {
                    registration.setName(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Name";
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
                const SizedBox(height: 10),
                Textfield(
                  keyboardType: TextInputType.text,
                  controller: email,
                  text: "Enter address",
                  onChanged: (value) {
                    registration.setEmail(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Email address";
                    }
                    if(value.isNotEmpty){
                      final bool isValid = EmailValidator.validate(email.text);
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
                const SizedBox(height: 10),
                Textfield(
                  keyboardType: TextInputType.number,
                  controller: phone,
                  text: "Enter Phone number",
                  onChanged: (value) {
                    registration.setPhone(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter phone number";
                    }
                      if(value.length!=10){
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
                const SizedBox(height: 10),
                Textfield(
                  keyboardType: TextInputType.text,
                  controller: password,
                  text: "Enter Password",
                  onChanged: (value) {
                    registration.setPassword(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Password";
                    }
                    const passwordPattern = r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$';
                    final regex = RegExp(passwordPattern);
                    if (!regex.hasMatch(value)) {
                      return 'capital letter, number, special character, 8 characters';
                    }
                    return null;

                  },
                ),

                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent.shade700,
                      minimumSize: const Size(140, 50),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ),
                    onPressed: () async {
                      if(personalKey.currentState!.validate()){
                        status = await registerPost(registration);
                        navigateToNextPage(status);
                      }
                    },
                    child: BasicText(
                      fontSize: 20,
                      title: "Register",
                      color: Colors.white,
                    ),
                  ),
                ),
                //Text(status!)
                const SizedBox(height: 15,),

                status!=null?Container(
                    alignment: Alignment.center,
                    child:Text(status!.toString(),
                      style: const TextStyle(color: Colors.red,
                        fontSize: 20
                      ),
                    )):Container(),


              ],
            ),
          ),

        ],
      ),
    );
  }

   registerPost(AdminRegistrationModel registration) async {
     //AdminRegistration adminRegistration = AdminRegistration();
     var headers = {
       'Content-Type': 'application/json'
     };
     var data = json.encode({
       "apartname": registration.apartName,
       "address": registration.apartAddress,
       "noOfFlats": int.parse(registration.noOfFlats),
       "name": registration.name,
       "email": registration.email,
       "phonenumber": registration.phone.toString(),
       "password": registration.password
     });
     var dio = Dio();
     var response = await dio.request(
       'http://192.168.29.69:3000/register',
       options: Options(
         method: 'POST',
         headers: headers,
       ),
       data: data,
     );

     if (response.statusCode == 200) {
        setState(() {
          print("${response.data["status"]} Data from server");
          status = response.data["status"];
        });
        return status;
     }
     else {
       print(response.statusMessage);
     }
  }

   navigateToNextPage(String? status) {
    if(status=="User registered successfully"){
      Provider.of<AdminRegistrationModel>(
          context,
          listen: false);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=>const Homepage()));
    }
  }
}
