import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/apartmentdetails.dart';
import 'package:maintaince_app/Admin/Model/blocks.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:provider/provider.dart';

import 'Admin/changeprovider/adminprovider.dart';
import 'Admin/changeprovider/api.dart';
import 'User/Views/user_registration.dart';

class ApartCode extends StatefulWidget {
  ApartCode({super.key});

  @override
  State<ApartCode> createState() => _ApartCodeState();
}

class _ApartCodeState extends State<ApartCode> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController apartmentId = TextEditingController();
  List<ApartmentDetails>? apartmentDetails;
  String? status;
  bool? messageId;
  bool? message;
  bool? flag;
 String? adminId;
  List<String>? blocknames = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundImage(
        child: Consumer<AdminRegistrationModel>(
          builder: (context, registration, child) {
            return SizedBox(
              // height: MediaQuery.of(context).size.height / 1.3,
              child: Form(
                key: formKey,
                child: ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(bottom: 3.4),
                      child: BasicText(title: "Enter Apartment Code"),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Textfield(
                              controller: apartmentId,
                              text: "Apartment Id",
                              keyboardType: TextInputType.text,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please Enter Apartment Code";
                                }
                                return null;
                              },
                              onChanged: (value){
                              /*  apartmentId.value = apartmentId.value.copyWith(
                                  text: value.replaceAll(' ', ''),
                                  selection: TextSelection.collapsed(offset: value.length),
                                );*/

                              },
                            ),
                          ),
                          messageId == false
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
                              height:
                              MediaQuery.of(context).size.height / 16.3,
                              child: Container(
                                margin: const EdgeInsets.only(left: 6),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      Colors.green.shade500),
                                  onPressed: () async {
                                    await getVerify();
                                    if(messageId==false){
                                      apartmentDetails = await ApiService().getApartmentDetails(apartmentId.text);
                                      print(apartmentDetails);
                                    }
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
                      ),
                    ),
                    if (message == false)
                      Container(
                        margin: const EdgeInsets.only(top: 5.3),
                        child: messageId == true
                            ? const Text(
                          "Apartment Id already Present",
                          style:
                          TextStyle(color: Colors.red, fontSize: 14.5),
                        )
                            : Container(),
                      )
                    else
                      Container(
                        margin: const EdgeInsets.only(top: 3.4),
                        child: Text(
                          messageId == true
                              ? "Id should be at least 4 characters and contain at least one number and one alphabet"
                              : "",
                          style:
                          const TextStyle(color: Colors.red, fontSize: 11.5),
                        ),
                      ),
                    Center(
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 4.0,
                            backgroundColor: Colors.orange,
                            minimumSize: const Size(160, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onPressed: () async {
                            print(messageId);
                              var blocks = await ApiService()
                                  .getBlocks(apartmentId.text);
                              print(apartmentDetails);
                              getNavigate(blocks,apartmentDetails,
                                  adminId
                              );

                          },
                          child: Text(
                            "Next",
                            style: GoogleFonts.acme(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> getVerify() async {
    const pattern = r'^(?=.*[a-zA-Z])(?=.*\d)(?=(?:[^a-zA-Z]*[a-zA-Z])).{1,}$';
    final regExp = RegExp(pattern);
    if (regExp.hasMatch(apartmentId.text)) {
      await postAdminId(apartmentId.text);
      setState(() {
        message = false;
      });
    } else {
      setState(() {
        message = true;
      });
    }
  }

  Future<void> postAdminId(String apartment_code) async {
    var headers = {'Content-Type': 'application/json'};
    var data = json.encode({"apartment_code": apartment_code});
    var dio = Dio();
    var response = await dio.get(
      'http://192.168.29.231:3000/checkAdminId/$apartment_code',
      options: Options(headers: headers),
      data: data,
    );
    if (response.statusCode == 200) {
      setState(() {
        messageId = response.data["message"];
        adminId = response.data["admin_id"];
      });
    }
  }

   getNavigate(List<BlockNames>? blocks, apartmentdetails, String? adminId) {
     List<String>? blocknames = getlistofStrings(blocks);
     print(apartmentdetails);
     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserRegistration(
         blocknames:blocknames, apartmentDetails:apartmentdetails,
       apartmentcode:apartmentId.text,adminId:adminId
     )));
   }
  List<String> getlistofStrings(List<BlockNames>? blocks) {
    print(blocks);
    List<String> blocknames = [];
    if (blocks != null) {
      for (var block in blocks) {
        if (block.blockName != null) {
          blocknames.add(block.blockName!);
        }
      }
    }
    return blocknames;
  }
}
