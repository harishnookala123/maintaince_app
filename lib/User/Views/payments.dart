import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Payments extends StatefulWidget {
  String?userid;
   Payments({super.key, this.userid });

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 120,
          width: 290,
          child: Card(
            elevation: 4.0,
            child: Column(
              children: <Widget>[
                Text("Payment"),
                Text("")
              ],
            ),
          ),
        ),
      ),);

  }
}
