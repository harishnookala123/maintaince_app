import 'package:flutter/material.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import '../../Admin/Model/usermodel.dart';

class InfoScreen extends StatelessWidget {
  final Users? user;

  const InfoScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0099CC),
      appBar: AppBar(
        foregroundColor: Colors.white,
        // backgroundColor: const Color(0xFF004170),
        backgroundColor: const Color(0xFF003366),
        title: const Text('User Info'),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3.5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${user?.first_name ?? ''}',
                      style:  TextStyle(
                        fontSize: getFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Email: ${user?.email ?? ''}',
                      style:  TextStyle(
                        fontSize: getFontSize(context, 16),
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Phone: ${user?.phone ?? ''}',
                      style:  TextStyle(
                        fontSize: getFontSize(context, 16),
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Block: ${user?.block_name ?? ''}',
                      style:  TextStyle(
                        fontSize: getFontSize(context, 16),
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Flat No: ${user?.flat_no ?? ''}',
                      style:  TextStyle(
                        fontSize: getFontSize(context, 16),
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'User Type: ${user?.user_type ?? ''}',
                      style:  TextStyle(
                        fontSize:getFontSize(context, 16),
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
