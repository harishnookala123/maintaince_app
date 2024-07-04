import 'dart:convert';
import 'package:dio/dio.dart';
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

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

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
  bool? flag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BackGroundImage(
        child: Consumer<AdminRegistrationModel>(
          builder: (context,registration,child){
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    //margin: const EdgeInsets.only(bottom: 15.3),
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
                          address: address,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 3.4),
                          child:  BasicText(
                            title: "Enter Apartment Code",
                          ),
                        ),
                        SizedBox(
                          //width: MediaQuery.of(context).size.width/2.0,
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.8,
                                  child: Textfield(
                                    controller: apartmentId,
                                    text: "Apartment Id",
                                    keyboardType: TextInputType.text,
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
                                            color: Colors.green, fontSize: 14),
                                      )
                                    ],
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

                        // Submit Button
                        Center(
                          child: SizedBox(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 4.0,
                                    backgroundColor: Colors.orange,
                                    minimumSize: const Size(160, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0))),
                                onPressed: () async {
                                  var value  = registration.firstname;
                                  if(formKey.currentState!.validate()&&messageId==true){
                                    var apartmentdetails = await ApiService().getApartmentDetails(apartmentId.text);

                                    Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                        UserSecondRegistration(apartmentDetails:apartmentdetails)),);
                                  }

                                },
                                child: Text("Next",
                                    style: GoogleFonts.acme(
                                        fontSize: 20, color: Colors.white)),
                              )),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),)

                ],
              ),
            );
          }
        )
      ),
    );
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
      'http://192.168.1.6:3000/checkAdminId',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      print(response.data);
      setState(() {
         messageId = response.data["message"];
      });
    }
  }
/*
  Future<List<ApartmentDetails>?> getApartmentDetails(String? apartmentCode) async {
    var headers = {'Content-Type': 'application/json'};
    var dio = Dio();

    try {
      final response = await http.get(Uri.parse(''
          'http://192.168.1.6:3000/userregister/$apartmentCode'));
      print(response.body);
      if (response.statusCode == 200) {
      }
    } catch (e) {
      print("Error: $e");
    }

    return null;
  }
*/

}
