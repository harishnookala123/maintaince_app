import 'package:flutter/material.dart';
import '../../Admin/Model/usermodel.dart';

class InfoScreen extends StatelessWidget {
  final Users? user;

  const InfoScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor: const Color(0xFF0078A7),
      backgroundColor:Colors.blue[50],
      appBar: AppBar(
        foregroundColor: Colors.black,
        // backgroundColor: const Color(0xFF004170),
        backgroundColor:Colors.blue[50],
        title: const Text('User Info'),
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Color(0xFF004170), Color(0xFF0078A7)],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${user?.first_name ?? ''}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Email: ${user?.email ?? ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Phone: ${user?.phone ?? ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Block: ${user?.block_name ?? ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Flat No: ${user?.flat_no ?? ''}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'User Type: ${user?.user_type ?? ''}',
                      style: const TextStyle(
                        fontSize: 16,
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
