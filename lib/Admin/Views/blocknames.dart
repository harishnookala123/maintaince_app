import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/Admin/Views/setupblock.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../../styles/apart_basic.dart';

class BlockName extends StatefulWidget {
  String? apartName;
  int? noOfBlocks;
  BlockName({super.key, this.apartName, this.noOfBlocks});

  @override
  State<BlockName> createState() => _BlockNameState();
}

class _BlockNameState extends State<BlockName> {
  var blockname = TextEditingController();
  var nooffloors = TextEditingController();
  int? blocks;
  final List<Map<String, dynamic>> _textFieldControllers = [];
 List value = [];
  @override
  void initState() {
    super.initState();
    _addNewTextFields(); // Add initial text fields
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
    int? numberofblocks = widget.noOfBlocks;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Apartment Information"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 1.8,
                    mainAxisSpacing: 12.0,
                ),
                itemCount: numberofblocks,
                itemBuilder: (context, index) {
                  value.insert(index, 'Setup ${String.fromCharCode(65 + index)}');
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12.3),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 4.0,
                      ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              SetUpblocks(
                                index: index,
                              )));
                        },
                        child: Text('Setup ${String.fromCharCode(65 + index)}')),
                  );
                })
          ],
        ),
      ),
    );
  }
}
