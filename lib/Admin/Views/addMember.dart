import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/coadminprovider.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:provider/provider.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => AddMemberState();
}

class AddMemberState extends State<AddMember> {
  var nameOfTheMember = TextEditingController();
  var designation = TextEditingController();
  var mobileNumber = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BackGroundImage(
          child: SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              child: Consumer<CoAdmin>(
                builder: (context,admin,child){
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        margin: const EdgeInsets.only(bottom: 15.3),
                        child: Text(
                          "Management Info",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.indigo,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            Form(
                              key: formKey,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                                    child: BasicText(
                                      title: "Name Of The Member : - ",
                                      color: Colors.black,
                                      fontSize: 14.7,
                                    ),
                                  ),
                                  Textfield(
                                    text: "Name of the Member",
                                    controller: nameOfTheMember,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Member Name";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 15.3, bottom: 8),
                                    child: BasicText(
                                      title: "Designation : - ",
                                      color: Colors.black,
                                      fontSize: 14.7,
                                    ),
                                  ),
                                  Textfield(
                                    text: "Designation",
                                    controller: designation,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please Enter Your Designation";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin:  const EdgeInsets.only(left: 15.3, bottom: 8),
                                    child: BasicText(
                                      title: " Phone Number : - ",
                                      color: Colors.black,
                                      fontSize: 14.7,
                                    ),
                                  ),
                                  Textfield(
                                    text: "Enter Phone Number",
                                    controller: mobileNumber,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter mobile Number";
                                      }
                                      if (value.length != 10) {
                                        return "Valid Mobile Number";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                        
                                      Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 4.0,
                                              backgroundColor: Colors.lightGreen,
                                              minimumSize: const Size(110, 45),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(25.0))),
                                          onPressed: () {
                                            if(formKey.currentState!.validate()){
                                            }
                                          },
                                          child:  Text(
                                              "Register",
                                              style: GoogleFonts.acme(
                                                  fontSize: 16,color: Colors.white
                                              )
                                          ),
                                        ),
                                      ),
                        
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      style: TextButton.styleFrom(),
                                      onPressed: () {
                                        if(formKey.currentState!.validate()){
                                        }
                                      },
                                      child:  Text(
                                          "Add Member",
                                          style: GoogleFonts.acme(
                                              fontSize: 16.5,color: Colors.black,
                                            decoration:  TextDecoration.underline,
                                            decorationThickness:2,
                                            decorationColor: Colors.black,
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
          ),
        )
    );
  }

}
