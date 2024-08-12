import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maintaince_app/Admin/Model/usermodel.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';

import 'package:maintaince_app/styles/basicstyles.dart';

class UserComplaints extends StatefulWidget {
  final Users? user;
  const UserComplaints({super.key, this.user});

  @override
  ComplaintsState createState() => ComplaintsState();
}

class ComplaintsState extends State<UserComplaints> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();
  String? selectedComplaint;

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 1.25;

    return Scaffold(
      backgroundColor: const Color(0xFF0099CC),
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: BasicText(
          title: 'Complaints Box',
          fontSize: 19,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF003366),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF003366), // Darker blue color at the top
              Color(0xFF0099CC), // Lighter blue color at the bottom
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    width: width,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Complaint Type',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                      ),
                      dropdownColor: const Color(0xFF6396F3),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      value: selectedComplaint,
                      items: <String>[
                        'Electricity',
                        'Plumbing',
                        'Maintenance',
                        'Others'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: BasicText(
                            title: value,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedComplaint = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a complaint type';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: width,
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  _image == null
                      ? Container(
                          margin: const EdgeInsets.only(left: 12.3, top: 12.4),
                          child: GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.attach_file_sharp,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                Text(
                                  " Please Attach a File",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Stack(
                          alignment: Alignment.topRight,
                          children: [
                            SizedBox(
                              width: 250,
                              child: Center(child: Image.file(_image!)),
                            ),
                            IconButton(
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 20,
                              ),
                              color: Colors.white,
                              padding: const EdgeInsets.all(8.0),
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                  const SizedBox(height: 20,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                       setState(() {
                         if(formKey.currentState!.validate()){
                            postComplaint(widget.user!.uid,context);
                         }
                       });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(
                          fontSize: 17,
                          color: Colors.green,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text('Submit',
                          style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: const Color(0xFF0099CC),
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

   postComplaint(String? uid, BuildContext context) async {
    var data = {
      "user_id": uid,
      "complaint_type": selectedComplaint,
      "description": descriptionController.text,
      "apartment_code" : widget.user!.apartment_code,
      "status" : "Pending"
    };
    var status = await ApiService().postComplaint(data,_image);

    if (status == "Complaint submitted successfully") {
       Navigator.pop(context);
    }
   }
}
