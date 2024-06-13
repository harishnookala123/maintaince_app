import 'package:flutter/material.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height/7.0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 15),
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

class GridItem extends StatefulWidget {
  final int index;

  const GridItem({super.key, required this.index});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:  InkWell(
        onTap: (){},
        child: Card(
          shadowColor: Colors.orange,
          surfaceTintColor: Colors.deepOrange.shade100,
          // color: Colors.orange.shade300,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: BasicText(
              title: names[widget.index],
              fontSize: 15,
            )
          ),
        ),
      ),
    );
  }
}
