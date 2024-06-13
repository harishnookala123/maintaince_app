import 'package:flutter/material.dart';
class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height/6.2;
      print(height);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          shrinkWrap: true,
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
            Container(
              margin: const EdgeInsets.all(15.3),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 13,
                    mainAxisExtent: height,
                    childAspectRatio: 12
                  ),
                  itemCount: 10, // Number of items in the grid
                  itemBuilder: (context, index) {
                    return GridItem(index: index);
                  },
                ),


            )
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
    return SizedBox(
      child:  Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            names[index], // Display name based on index
            style: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}
