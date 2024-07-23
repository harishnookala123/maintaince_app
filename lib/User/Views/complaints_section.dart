
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/Model/usermodel.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';

import 'package:maintaince_app/styles/basicstyles.dart';

class Complaints extends StatefulWidget {
  Users? user;
   Complaints({super.key,this.user });

  @override
  ComplaintsState createState() => ComplaintsState();
}

class ComplaintsState extends State<Complaints> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BasicText(
          title: 'Complaints Box',
          fontSize: 19,
          color: Colors.blue,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                   var value= await ApiService().postComplaint(widget.user!.uid!, descriptionController.text);
                    if(value!=null){
                      Navigator.pop(context);
                    }
                   },

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 16,),
                  ),
                  child: const Text('Submit',style: TextStyle(color: Colors.blue),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}