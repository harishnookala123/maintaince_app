import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/User/Views/homescreen.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:maintaince_app/styles/drawer_style.dart';

import '../../Admin/Model/usermodel.dart';

class Expenses extends StatefulWidget {
  Users? user;
  Expenses({super.key, this.user});

  @override
  ExpensesState createState() => ExpensesState();
}

class ExpensesState extends State<Expenses> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController otherExpenseController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? selectedExpense;
  String? status;
  String? selectedvalue;

  @override
  void dispose() {
    otherExpenseController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 1.25;
    return Scaffold(
      backgroundColor: Color(0xFF0078A7) ,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF004170),
        title: BasicText(
          title: 'Apartment Name',
          fontSize: 19,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF004170), Color(0xFF0078A7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const ScrollPhysics(),
            children: [
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width,
                      child: DropdownButtonFormField<String>(
                        icon: Icon(Icons.arrow_drop_down_outlined,
                        color: Colors.white,),
                        decoration: InputDecoration(
                          labelText: 'Select Expense',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                        ),
                        dropdownColor:const Color(0xFF82B0F3),
                        value: selectedExpense,
                        items: <String>[
                          'Electricity',
                          'Plumbing',
                          'Maintenance',
                          'Others'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: BasicText(title:value,
                            color: Colors.white),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedExpense = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select an expense';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: width,
                      child: TextFormField(
                        controller: otherExpenseController,
                        decoration: InputDecoration(
                          labelText: 'Enter Description',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Description';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: width,
                      child: TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'Enter Amount',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              getPostexpenses(widget.user!.uid);
                            });
                          }
                        },
                        child:  Text(
                          'Submit',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF003366),
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPostexpenses(String? uid) async {
    Map<String, dynamic> data = {
      'expense_date': DateTime.now().toString(),
      'expense_type': selectedExpense,
      'description': otherExpenseController.text,
      'attachment': "",
      'amount': amountController.text,
      'status': "Pending",
      'remarks': "",
      'appartment_code': widget.user!.apartment_code,
      "userid": uid,
      "block_name": widget.user!.block_name,
      "confirm": "no"
    };
    status = await ApiService().postexpenses(uid, data);
    if (status == "Expense inserted successfully") {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          UserHomeScreen(user: widget.user)
      ));
    }
  }
}
