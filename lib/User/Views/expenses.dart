import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/User/Views/user_checklist.dart';
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

  String?status;

  String? selectedvalue;

  @override
  void dispose() {
    otherExpenseController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var apartmentcode = widget.user!.apartment_code;
    return Scaffold(
      appBar: AppBar(
        title: BasicText(
          title: 'Apartment Name',
          fontSize: 19,
          color: Colors.blue,
        ),
      ),
      drawer: CustomDrawer(user: widget.user),
      body: Padding(
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
                  FutureBuilder<List<String>?>(
                    future: ApiService().getBlockName(apartmentcode),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        List<String>? blocknames = snap.data;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal:20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                child: BasicText(
                                  title: "Select Block",
                                  fontSize: 16.5,
                                  color: Colors.pinkAccent.shade400,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.35,
                                child: DropdownButtonFormField2<String>(
                                  isDense: true,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    enabled: true,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 22),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15.4),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.4),
                                    ),
                                  ),
                                  hint: const Text(
                                    'Select Block',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  value: selectedvalue,
                                  items: blocknames!
                                      .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item.toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400, fontSize: 18),
                                    ),
                                  ))
                                      .toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select block.';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      selectedvalue = value.toString();
                                    });
                                  },
                                  onSaved: (value) {
                                    selectedvalue = value.toString();
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding: EdgeInsets.only(right: 8),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    iconSize: 25,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    elevation: 12,
                                    maxHeight: MediaQuery.of(context).size.height / 2.7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    padding: EdgeInsets.symmetric(horizontal: 25),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                   const SizedBox(height: 20,),
                  SizedBox(
                    width: 320,
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Expense',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedExpense,
                      items: <String>[
                        'Electricity',
                        'Plumbing',
                        'Maintenance',
                        'Others'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
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
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1.25,
                    child: TextFormField(
                      controller: otherExpenseController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Description';
                        }
                        return null;
                      },
                    ),
                  ),
                  if (selectedExpense == 'Others') ...[
                    const SizedBox(height: 16.0),

                  ],
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1.25,
                    child: TextFormField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Amount',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(30, 50),
                        elevation: 4.0,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                             setState(() {
                               getPostexpenses(widget.user!.uid);
                             });
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   getPostexpenses(String? uid) async {
    Map<String,dynamic>data = {
      'expense_date': DateTime.now().toString(),
      'expense_type': selectedExpense,
      'description': otherExpenseController.text,
      'attachment': "",
      'amount': amountController.text,
      'status': "Pending",
      'remarks': "",
      'appartment_code' : widget.user!.apartment_code,
      "userid" : uid,
      "block_name" : selectedvalue
    };
    status =  await ApiService().postexpenses(uid,data);
    if(status == "Expense inserted successfully"){
       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
       UserHomeScreen(user: widget.user)
       ));
    }
   }
}
