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
