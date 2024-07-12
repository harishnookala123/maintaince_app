import 'package:flutter/material.dart';
import '../../Admin/Model/usermodel.dart';

class InfoScreen extends StatelessWidget {
  final Users? user;

  const InfoScreen({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          child: SizedBox(
            width:double.infinity,
            height:MediaQuery.of(context).size.height / 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${user?.first_name ?? ''}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Email: ${user?.email ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Phone: ${user?.phone ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8.0),
                  Text(
                    'Block: ${user?.block_name ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Flat No: ${user?.flat_no ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'User Type: ${user?.user_type ?? ''}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
