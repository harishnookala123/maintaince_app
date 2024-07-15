import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    otherExpenseController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Form(
              key: formKey,
              child: Column(
                children: [
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
                  if (selectedExpense == 'Others') ...[
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: otherExpenseController,
                      decoration: const InputDecoration(
                        labelText: 'Enter Expense',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an expense';
                        }
                        return null;
                      },
                    ),
                  ],
                  const SizedBox(height: 16.0),
                  TextFormField(
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
                          // Handle form submission
                          if (selectedExpense == 'Others') {
                            print('Selected Expense: ${otherExpenseController.text}');
                          } else {
                            print('Selected Expense: $selectedExpense');
                          }
                          print('Entered Amount: ${amountController.text}');
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
}
