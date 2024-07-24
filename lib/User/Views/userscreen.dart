import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';

import '../../Admin/Model/usermodel.dart';
import '../../login.dart';

class Userscreen extends StatefulWidget {
  String?user_id;
   Userscreen({super.key,this.user_id});

  @override
  State<Userscreen> createState() => _UserscreenState();
}

class _UserscreenState extends State<Userscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            FutureBuilder<Users?>(
                future: ApiService.userData(widget.user_id!), 
                builder: (context,snap){
                  if(snap.hasData){
                    var users = snap.data;
                    return users!.status=="Pending"?Column(
                      children: [
                        Text(users.first_name!),
                        Text("Your status is ${users.status!}"),
                        Text(users.apartment_name!),
                        Text(users.block_name.toString().toUpperCase()),
                        Text(users.flat_no!),
                        Text(users.user_type!)
                      ],
                    ):const Column(
                      children: [
                        Text("ddg"),
                      ],
                    );
                  }return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.pinkAccent,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
