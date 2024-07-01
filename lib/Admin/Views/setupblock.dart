import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

class SetUpblocks extends StatefulWidget {
  int? index;
  SetUpblocks({super.key, this.index});

  @override
  State<SetUpblocks> createState() => _SetUpblocksState();
}

class _SetUpblocksState extends State<SetUpblocks> {
  var blockname = TextEditingController();
  var nooffloors = TextEditingController();
  final List<Map<String, dynamic>> _textFieldControllers = [];
  var floors;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Block Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 12.0,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.actor(
          fontSize: 18.6,
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicText(
                title: "Enter Block name",
                color: Colors.black,
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/1.3,
                child: Textfield(
                  controller: blockname,
                  keyboardType: TextInputType.text,
                  text: "Enter block name",
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BasicText(
                title: "Enter no of Floors",
              ),
              const SizedBox(
                height: 6,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/1.3,
                child: Textfield(
                  controller: nooffloors,
                  keyboardType: TextInputType.number,
                  text: "Enter no of floors",
                  onChanged: (value) {
                    setState(() {
                      floors = value;
                      print(floors);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              floors != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicText(
                    title: "Enter Range of Floor Details",
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                   // height: 300, // Constrain the height of the ListView
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: _textFieldControllers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            BasicText(
                                title: "${index + 1} Floor"),
                            const SizedBox(height: 3),
                            basicText(index, _textFieldControllers),
                          ],
                        );
                      },
                    ),
                  ),
                 const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(140, 50),
                          elevation: 8.0,
                          backgroundColor: Colors.purple
                        ),
                        onPressed: () {
                          _submitData();
                        },
                        child: const Text("Save",
                         style: TextStyle(color: Colors.white,
                           fontSize: 18
                         ),
                        )),
                  ),
                ],
              )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }


  void _submitData() {
    for (var controllers in _textFieldControllers) {
      String from = controllers['from']?.text ?? '';
      String to = controllers['to']?.text ?? '';
      List<String> rangeValues = _getValuesInRange(from, to);
      print(rangeValues);
      print('From: $from, To: $to, Range: $rangeValues');
    }
  }

  Widget basicText(int index, List<Map<String, dynamic>> textFieldControllers) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _textFieldControllers[index]['from'],
            decoration: const InputDecoration(
                labelText: 'From'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.text,
            controller: _textFieldControllers[index]['to'],
            decoration: const InputDecoration(
                labelText: 'To'),
          ),
        ),
        IconButton(
          icon: Icon(
            _textFieldControllers[index]['isAddButton']
                ? Icons.add
                : Icons.remove,
            color: _textFieldControllers[index]['isAddButton']
                ? Colors.green
                : Colors.red,
          ),
          onPressed: () {
            _textFieldControllers[index]['isAddButton']
                ? _toggleButton(index)
                : _removeTextFields(index);
          },
        ),
      ],
    );
  }
  List<String> _getValuesInRange(String from, String to) {
    final fromAlphaMatch = RegExp(r'^[a-zA-Z]+').firstMatch(from);
    final toAlphaMatch = RegExp(r'^[a-zA-Z]+').firstMatch(to);

    final fromAlpha = fromAlphaMatch != null ? fromAlphaMatch.group(0) : '';
    final toAlpha = toAlphaMatch != null ? toAlphaMatch.group(0) : '';

    final fromNum = int.parse(from.substring(fromAlpha!.length));
    final toNum = int.parse(to.substring(toAlpha!.length));

    List<String> rangeValues = [];
    for (int i = fromNum; i <= toNum; i++) {
      rangeValues.add('${fromAlpha}${i.toString().padLeft(from.length - fromAlpha.length, '0')}');
    }
    return rangeValues;
  }
}
