import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addMember.dart';
class DrawerDetails extends StatefulWidget {
  const DrawerDetails({super.key});

  @override
  State<DrawerDetails> createState() => _DrawerDetailsState();
}

class _DrawerDetailsState extends State<DrawerDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18.4),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          TextButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AddMember()));
          } , child: const Text("Add Member"))
        ],
      ),
    );
  }
}
