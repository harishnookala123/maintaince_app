import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:maintaince_app/login.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import '../../styles/basicstyles.dart';
import 'adminscreen.dart';

class AdminPersonal extends StatefulWidget {
  const AdminPersonal({super.key});
  @override
  State<AdminPersonal> createState() => _AdminPersonalState();
}

class _AdminPersonalState extends State<AdminPersonal> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> personalKey = GlobalKey<FormState>();
  TextEditingController apartmentId = TextEditingController();
  String? status;
  bool? messageId;

  bool? message;

  bool? flag;
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
                            padding: const EdgeInsets.all(12.0),
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
                CommonTextField(
                 firstName: firstName,
                  lastName: lastName,
                  email: email,
                  phone: phone,
                  password: password,
                ),
                const SizedBox(height: 10),

                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    //width: MediaQuery.of(context).size.width/2.0,
                    child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                     // margin: const EdgeInsets.only(left: 12.4),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 1.8,
                        child: Textfield(
                          controller: apartmentId,
                          text: "Apartment Id",
                          keyboardType: TextInputType.text,
                          validator: (value) {},
                        ),
                      ),
                    ),
                    messageId == true
                        ? Container(
                      // margin: const EdgeInsets.only(left: 5),
                          child:  const SizedBox(
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
                          ),
                        )
                        : Expanded(
                            child: SizedBox(
                              // width: 280,
                              // height: 50,
                              height: MediaQuery.of(context).size.height/16.3,
                              child: Container(
                                margin: const EdgeInsets.only(left:6),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green.shade500),
                                  onPressed: () async {
                                    await getVerify();
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
                )),
                message == false
                    ? Container(
                       margin: const EdgeInsets.only(top: 5.3),
                        child: messageId == false
                            ? const Text("Apartment Id already Present ",
                         style: TextStyle(color: Colors.red,
                          fontSize: 14.5
                         ),
                        )
                            : Container(),
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
                  height: 20,
                ),
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
                      }else{
                        setState(() {
                          message = true;
                        });
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
                const SizedBox(
                  height: 15,
                ),

                status != null
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          status!.toString(),
                          style:
                              const TextStyle(color: Colors.red, fontSize: 20),
                        ))
                    : Container(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  registerPost(AdminRegistrationModel registration) async {
    //AdminRegistration adminRegistration = AdminRegistration();
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({
      "apartname": registration.apartName,
      "address": registration.apartAddress,
      "name": registration.name,
      "email": registration.email,
      "phonenumber": registration.phone.toString(),
      "password": registration.password,
      "user_type": "admin",
      "adminId": "A${registration.name}",
      "apartId": apartmentId.text,
    });
    var dio = Dio();

    var response = await dio.request(
      'http://192.168.29.231:3000/register',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      setState(() {
        print(response.data);
        print("${response.data["status"]} Data from server");
        status = response.data["status"];
        print(response.data["id"]);
      });
      return status;
    } else {
      print("Har");
      print(response.statusMessage);
    }
  }

  navigateToNextPage(String? status) {
    if (status == "Admin is registered") {
       Provider.of<AdminRegistrationModel>(
          context,
          listen: false);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=> const Login()));
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

  getVerify() async {
    const pattern = r'^(?=.*[a-zA-Z])(?=.*\d)(?=(?:[^a-zA-Z]*[a-zA-Z])).{1,}$';
    final regExp = RegExp(pattern);
    if (regExp.hasMatch(apartmentId.text)) {
      await postAdminId(apartmentId.text);
      setState(() {
        message = false;
      });
    } else if(!regExp.hasMatch(apartmentId.text)) {
      setState(() {
        message = true;
      });
    }
  }
}