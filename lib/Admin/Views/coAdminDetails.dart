import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import 'addMember.dart';


class CoAdminDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey.shade300,
          body: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                BasicText(
                  title: 'Co-Admin Details',
                  fontSize: 20,
                  color: Colors.black,
                ),
                // Spacer(flex: 3), // Adds space between the text and button
             Expanded(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ElevatedButton(
                     onPressed: () {},
                     style: ElevatedButton.styleFrom(
                       side: const BorderSide(color: Colors.black38, width: 1),
                       elevation: 2,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(14),
                       ),
                       backgroundColor: Colors.orange,
                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                     ),
                     child: BasicText(
                       title: 'Co-Admin info',
                       fontSize: 16,
                       color: Colors.white,
               
                     ),
                   ),
                   const SizedBox(
                     height: 14,
                   ),
                   ElevatedButton(
                     onPressed: () {
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) =>  AddMember()));
                     },
                     style: ElevatedButton.styleFrom(
                       side: const BorderSide(color: Colors.black38, width: 1),
                       elevation: 2,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(14),

                       ),
                       backgroundColor: Colors.orange,
                       padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 12),
                     ),
                     child: BasicText(
                       title: 'Add Member',
                       fontSize: 16,
                       color: Colors.white,
               
                     ),
                   ),
                 ],
               ),
             ),
                // Spacer(flex: 3),
              ],
            ),
          ),
        ));
  }
}
