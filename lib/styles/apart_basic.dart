import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

class ApartInformation extends StatelessWidget {
  var apartname = TextEditingController();
  var noofblocks = TextEditingController();
  bool? pressed;
  ApartInformation(
      {super.key,
      required this.apartname,
      required this.noofblocks,
       this.pressed,
      });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BasicText(
            title: "Enter apartment name",
            fontSize: 15,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Textfield(
            controller: apartname,
            keyboardType: TextInputType.text,
            text: "Enter apartment name",
          ),
          const SizedBox(
            height: 7,
          ),
          BasicText(
            title: "Enter no of Blocks",
            fontSize: 15,
            color: Colors.black,
          ),
          const SizedBox(
            height: 7,
          ),
          Textfield(
            controller: noofblocks,
            keyboardType: TextInputType.number,
            text: "Enter no of Blocks",
          ),
          const SizedBox(
            height: 10,
          ),
          ],
      ),
    );
  }
}
