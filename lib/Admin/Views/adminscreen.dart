import 'package:flutter/material.dart';

void main() {
  runApp(AdminScreen());
}

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Apartment Name',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              '20,000',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 10, // Number of items in the grid
                itemBuilder: (context, index) {
                  return GridItem(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final List<String> names = [
    'Flat List',
    'Co-Admin',
    'Users',
    'Security Details',
    'Expense Request',
    'Complaints',
    'Visitor Info',
    'Reports',
    'Announcements',
    'Emergency'
  ];
  final int index;

  GridItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          names[index], // Display name based on index
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
