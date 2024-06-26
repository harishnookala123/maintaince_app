import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

class DynamicTextFieldsPage extends StatefulWidget {
  @override
  _DynamicTextFieldsPageState createState() => _DynamicTextFieldsPageState();
}

class _DynamicTextFieldsPageState extends State<DynamicTextFieldsPage> {
  final List<Map<String, dynamic>> _textFieldControllers = [];
  String? selectBlock;
  List blocks = ["Multiple Blocks", "Single Block"];
  TextEditingController numberOfblocks = TextEditingController();
  TextEditingController nameOfblock = TextEditingController();
  TextEditingController floors = TextEditingController();
  TextEditingController flatrange = TextEditingController();

  // Define new TextEditingControllers
  TextEditingController newController1 = TextEditingController();
  TextEditingController newController2 = TextEditingController();

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
    newController1.dispose();
    newController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Apartment Name'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: const EdgeInsets.all(12.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12.3),
                child: BasicText(
                  title: "Type of Building",
                ),
              ),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                hint: const Text(
                  'Select Your Building',
                  style: TextStyle(fontSize: 14),
                ),
                items: blocks
                    .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select user Type.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectBlock = value.toString();
                  });
                },
                onSaved: (value) {
                  setState(() {
                    selectBlock = value.toString();
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.only(right: 8),
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 24,
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),

              // New text fields under the dropdown
              selectBlock == "Multiple Blocks"
                  ? Column(
                children: [
                  const SizedBox(height: 20),
                  Textfield(
                    controller: newController1,
                    text: "Enter No Of Blocks",
                    keyboardType: TextInputType.number,

                  ),
                  const SizedBox(height: 20),
                  Textfield(
                    controller: newController1,
                    text: "Enter No Of Floors",
                    keyboardType: TextInputType.number,

                  ),
                  const SizedBox(height: 20),
                ],
              )
                  : Container(),

              selectBlock == "Multiple Blocks"
                  ? Expanded(
                child: ListView.builder(
                  itemCount: _textFieldControllers.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text("${index + 1} Floor"),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _textFieldControllers[index]
                                ['from'],
                                decoration: const InputDecoration(
                                    labelText: 'From'),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _textFieldControllers[index]
                                ['to'],
                                decoration:
                                const InputDecoration(labelText: 'To'),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _textFieldControllers[index]['isAddButton']
                                    ? Icons.add
                                    : Icons.remove,
                                color: _textFieldControllers[index]
                                ['isAddButton']
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              onPressed: () {
                                _textFieldControllers[index]
                                ['isAddButton']
                                    ? _toggleButton(index)
                                    : _removeTextFields(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              )
                  : Container(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitData() {
    // Collect all the data from the text fields
    for (var controllers in _textFieldControllers) {
      print('From: ${controllers['from']?.text}, To: ${controllers['to']?.text}');
    }
    // Collect data from new text fields
    if (selectBlock == "Multiple Blocks") {
      print('Enter Blocks: ${newController1.text}');
      print('Enter Flat Numbers: ${newController2.text}');
    }
  }
}
