import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/adminprovider.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/login.dart';
import 'package:provider/provider.dart';
import '../../styles/basicstyles.dart';
import 'apart_details.dart';

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
  String? userid;
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
                        if(status=="Admin is registered"){
                          navigateToNextPage(registration);
                        }
                      }
                    },
                    child: BasicText(
                      fontSize: 20,
                      title: "Next",
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
      "email": email.text,
      "password": password.text,
      "user_type": "admin",
      "user_id": "A${firstName.text}"
    });
    var dio = Dio();

    var response = await dio.request(
      '$baseUrl/registerAdmin',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      setState(() {
        print(response.data);
        print("${response.data["status"]}");
        status = response.data["status"];
        userid = response.data["userid"];
        print(response.data["id"]);
      });
      return status;
    } else {
       print("hai");
    }
  }

  navigateToNextPage(AdminRegistrationModel registration) {
       Provider.of<AdminRegistrationModel>(
          context,
          listen: false);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context)=> ApartmentDetails(
            userid: userid,registration:registration
          )));


  }

  postAdminId(String apartId) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"apartment_code": apartId});
    var dio = Dio();
    var response = await dio.request(
      'http://192.168.1.6:3000/checkAdminId',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      setState(() {
        messageId = response.data["message"];
        print(messageId);
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