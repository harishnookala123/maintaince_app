import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Views/setupblock.dart';
import 'package:provider/provider.dart';
import '../changeprovider/apartmentdetails.dart';

class BlockName extends StatefulWidget {
  const BlockName({super.key});

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
    print("Hreg");
    // int? numberofblocks = widget.noOfBlocks;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Block Set up",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ApartDetails>(
              builder: (context, details, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 6.0,
                    childAspectRatio: 12.0 / 5.0,
                  ),
                  itemCount: details.block,
                  itemBuilder: (context, index) {
                    //value.insert(index, 'Setup ${String.fromCharCode(65 + index)}');
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12.3),
                      child: SizedBox(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 4.0,
                            backgroundColor: const Color(0xff78d0f6),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SetUpblocks(
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Setup ${String.fromCharCode(65 + index)}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
