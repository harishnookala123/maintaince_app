
import 'package:flutter/material.dart';
import 'package:maintaince_app/User/Views/expenses.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../../styles/drawer_style.dart';

class Expensive extends StatelessWidget {
  const Expensive({super.key});

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
       drawer:  const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              surfaceTintColor: Colors.orange.shade600,
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.money),
                title: const Text('Expenses',style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18 ),),
                onTap: () {
                  // Handle navigation to Expenses
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Expenses()));
                },
              ),
            ),
            const SizedBox(height: 16.0), // Add spacing between cards
            Card(
              surfaceTintColor: Colors.orange.shade600,
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.report_problem),
                title: const Text('Grievance',style: TextStyle(fontWeight:FontWeight.w500,fontSize: 18  ),),
                onTap: () {
                  // Handle navigation to Grievance
                },
              ),
            ),
            const SizedBox(height: 16.0), // Add spacing between cards
            Card(
              elevation: 2,
              surfaceTintColor: Colors.orange.shade600,
              child: ListTile(
                leading: const Icon(Icons.error),
                title:  const Text('Complaints',style: TextStyle(fontWeight:FontWeight.w500 ,fontSize: 18 ),),
                onTap: () {
                  // Handle navigation to Complaints
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

