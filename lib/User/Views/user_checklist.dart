import 'package:flutter/material.dart';
import 'package:maintaince_app/User/Views/expenses.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../../Admin/Model/usermodel.dart';
import '../../styles/drawer_style.dart';

class UserHomeScreen extends StatelessWidget {
  final Users? user;

  UserHomeScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  const Color(0xFFE0FFFF) ,
        title: BasicText(
          title: user!.apartment_name,
          fontSize: 19,
          color: Colors.blue,
        ),
      ),
      drawer: CustomDrawer(user: user),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0FFFF), // Light Cyan
              Color(0xFFF0F8FF), // Alice Blue
            ],
            stops: [0.0, 0.7],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildCard(
                icon: Icons.money,
                title: 'Expenses',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Expenses(user: user),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              buildCard(
                icon: Icons.report_problem,
                title: 'Grievance',
                onTap: () {
                  // Handle navigation to Grievance
                },
              ),
              const SizedBox(height: 16.0),
              buildCard(
                icon: Icons.error,
                title: 'Complaints',
                onTap: () {
                  // Handle navigation to Complaints
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      shadowColor: Colors.orange.shade300,
      child: ListTile(
        leading: Icon(icon, color: Colors.orange.shade600),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
