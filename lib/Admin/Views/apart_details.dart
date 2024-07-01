import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../../styles/apart_basic.dart';
import 'blocknames.dart';

class ApartmentDetails extends StatefulWidget {
  const ApartmentDetails({super.key});

  @override
  State<ApartmentDetails> createState() => _ApartmentDetailsState();
}

class _ApartmentDetailsState extends State<ApartmentDetails> {
  var apartname = TextEditingController();
  var noofblocks = TextEditingController();
  var nooffloors = TextEditingController();
  TextEditingController _controller = TextEditingController();

  final List<Map<String, dynamic>> _textFieldControllers = [];
  var blockname = TextEditingController();
  int? blocks;
  bool pressed = false;
  @override
  void initState() {
    super.initState();
    _addNewTextFields();// Add initial text fields

  }

  void _addNewTextFields() {
    setState(() {
      _textFieldControllers.add({
        'from': TextEditingController(),
        'to': TextEditingController(),
        'isAddButton': true, // Initially, the button is the "+" button
      });
    });
  }
  void _toggleButton(int index) {
    setState(() {
      _textFieldControllers[index]['isAddButton'] = false; // Change "+" to "-"
      _addNewTextFields(); // Add a new row of text fields
    });
  }

  void _removeTextFields(int index) {
    setState(() {
      _textFieldControllers[index]['from']?.dispose();
      _textFieldControllers[index]['to']?.dispose();
      _textFieldControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    // Dispose of all the controllers when the widget is disposed
    for (var controllers in _textFieldControllers) {
      controllers['from']?.dispose();
      controllers['to']?.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepOrangeAccent.shade200,
            centerTitle: true,
            title: BasicText(
              color: Colors.white,
              title: "Apartment Details",
              fontSize: 16.5,
            )),
        body: Container(
            margin: const EdgeInsets.all(13.3),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 12.3,right: 12.3),
                        child: ApartInformation(
                          apartname: apartname,
                          noofblocks: noofblocks,
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.green,
                            elevation: 3.0,
                            minimumSize: const Size(120, 50)),
                        onPressed: _submitData,
                        child: BasicText(
                          title: "Continue",
                          fontSize: 17,
                          color: Colors.white,
                        ),
                    ),
                  )
                ],
              ),
            )));
  }

  void _submitData() {
    setState(() {
      blocks = int.parse(noofblocks.text);
      pressed = true;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=>BlockName(
      apartName : apartname.text,
      noOfBlocks : int.parse(noofblocks.text)
    )));
    // Collect all the data from the text fields
    /*  for (var controllers in _textFieldControllers) {
      print('From: ${controllers['from']?.text}, To: ${controllers['to']?.text}');
    }*/
  }
}
