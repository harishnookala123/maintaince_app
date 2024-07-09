import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import 'package:maintaince_app/styles/drawer_style.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  ExpensesState createState() => ExpensesState();
}

class ExpensesState extends State<Expenses> {
  final formKey = GlobalKey<FormState>();
  String? selectedExpense;

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
      drawer: const CustomDrawer(),
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
                    width: 320, // Set the width as per your requirement
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
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 160, // Set the width as per your requirement
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(30, 50),
                        elevation: 4.0,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // Handle form submission
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 20,),
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
