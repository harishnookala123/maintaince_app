import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Views/registrationsecondpage.dart';
import 'package:provider/provider.dart';
import '../../styles/basicstyles.dart';
import '../changeprovider/adminprovider.dart';

class AdminRegistration extends StatefulWidget {
  const AdminRegistration({super.key});

  @override
  State<AdminRegistration> createState() => _AdminRegistrationState();
}

class _AdminRegistrationState extends State<AdminRegistration> {
  TextEditingController apartName = TextEditingController();
  TextEditingController apartAddress = TextEditingController();
  TextEditingController noOfFlats = TextEditingController();
  TextEditingController images = TextEditingController();
  final GlobalKey<FormState> registrationKey = GlobalKey<FormState>();

  @override
  void dispose() {
    apartName.dispose();
    apartAddress.dispose();
    noOfFlats.dispose();
    images.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        width: MediaQuery.of(context).size.width/1.05,
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
                                  margin: const EdgeInsets.only(top: 2.4,
                                   bottom: 15.3
                                  ),
                                  child: Text(
                                    "Admin Registration",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                buildForm(registration),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm(AdminRegistrationModel registration) {
    return Form(
      key: registrationKey,
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
                    title: "Apartment Name : - ",
                    color: Colors.black,
                    fontSize: 15.5,
                  ),
                ),
                const SizedBox(height: 10),
                Textfield(
                  keyboardType: TextInputType.text,
                  controller: apartName,
                  text: "Name of Apartment",
                  onChanged: (value) {
                    registration.setApartName(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Apartment Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 15.3),
                  child: BasicText(
                    title: "Apartment Address : - ",
                    color: Colors.black,
                    fontSize: 15.5,
                  ),
                ),
                const SizedBox(height: 10),
                Textfield(
                  keyboardType: TextInputType.multiline,
                  controller: apartAddress,
                  text: "Enter address",
                  onChanged: (value) {
                    registration.setApartAddress(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter Address";
                    }return null;
                  },
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 15.3),
                  child: BasicText(
                    title: "No of Flats : - ",
                    color: Colors.black,
                    fontSize: 15.5,
                  ),
                ),
                const SizedBox(height: 10),
                Textfield(
                  keyboardType: TextInputType.number,
                  controller: noOfFlats,
                  text: "Enter no Of Flats",
                  onChanged: (value) {
                    registration.setNoOfFlats(value);
                  },
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter no Of Flats";
                    }return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent.shade700,
                      minimumSize: const Size(140, 50),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.5),
                      ),
                    ),
                    onPressed: () {
                      if(registrationKey.currentState!.validate()){
                         Provider.of<AdminRegistrationModel>(
                            context,
                            listen: false);
                         Navigator.of(context).push(MaterialPageRoute
                           (builder: (context)=>const AdminPersonal()));
                      }
                    },
                    child: BasicText(
                      fontSize: 20,
                      title: "Next",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
