import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../login.dart';
class UserScreen  extends StatelessWidget {

  String? name;

  UserScreen({super.key, this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text(name!,style: const TextStyle(fontSize: 40),),),
            Text("Your Status is Pending ",
             style: TextStyle(color: Colors.pink.shade300),
            ),
            const SizedBox(height: 20,),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder:
                  (context)=>const Login()));
            }, child: const Text("Logout",
              style: TextStyle(color: Colors.blue,fontSize: 18),
            ))
          ],
        )
    );
  }
}
