import 'package:flutter/material.dart';
import 'package:maintaince_app/User/Views/complaints_section.dart';
import 'package:maintaince_app/User/Views/expenses.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../../Admin/Model/usermodel.dart';
import '../../styles/drawer_style.dart';
import 'billpayments.dart';

class UserHomeScreen extends StatefulWidget {
  final Users? user;

   UserHomeScreen({super.key, this.user});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0FFFF),
        title: BasicText(
          title: "welcome ${widget.user!.first_name}",
          fontSize: 22,
          color: Colors.black,
        ),
      ),
      drawer: CustomDrawer(user: widget.user),
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
          child: ListView(
            shrinkWrap: true,
            children: [
              buildCard(
                icon: Icons.monetization_on_sharp,
                title: 'Rise Expenses',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Expenses(user: widget.user),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>   Complaints(user:widget.user),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              buildCard(
                icon: Icons.error,
                title: 'Maintenance Bill Payments',
                onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                     builder: (context)=>UserBills(userid: widget.user!.uid!,)));
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.orange.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100,
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.orange.shade900, size: 27),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
