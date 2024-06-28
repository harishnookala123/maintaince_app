import 'package:dropdown_button2/dropdown_button2.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int?noOfBlocks = 0;
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
            children: [
              selectBlock=="Multiple Blocks"?Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 12.3),
                      alignment: Alignment.topLeft,
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
                        //Do something when selected item is changed.
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
                    const SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.topLeft,
                      child: BasicText(
                        title: "Enter no of Blocks",
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Textfield(
                      controller: numberOfblocks,
                      keyboardType: TextInputType.number,
                      text: "Enter no of Blocks",
                      validator: (value){
                        if(value!.isNotEmpty){
                          return "Please Enter no of Blocks";
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(140, 55),
                          backgroundColor: Colors.deepOrangeAccent.shade200,
                        ),
                        onPressed: (){},
                        child: const Text("Continue",
                        style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),),
                    )
                  ],
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }

/*  void _submitData() {
    // Collect all the data from the text fields
    for (var controllers in _textFieldControllers) {
      print(
          'From: ${controllers['from']?.text}, To: ${controllers['to']?.text}');
    }
  }*/
}
