import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class UserScreen  extends StatelessWidget {

  String? name;

  UserScreen({super.key, this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Text(name!,style: TextStyle(fontSize: 40),),)
          ],
        )
    );
  }
}
