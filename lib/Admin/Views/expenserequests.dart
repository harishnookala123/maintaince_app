import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/basicstyles.dart';
import '../changeprovider/api.dart';
class Expenserequests extends StatefulWidget {
  String? apartid;
  Expenserequests({super.key, this.apartid});

  @override
  State<Expenserequests> createState() => _ExpenserequestsState();
}

class _ExpenserequestsState extends State<Expenserequests> {
  String? selectedvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 30,),
            FutureBuilder<List<String>?>(
              future: ApiService().getBlockName(widget.apartid),
              builder: (context, snap) {
                if (snap.hasData) {
                  List<String>? blocknames = snap.data;
                  return Container(
                    margin: const EdgeInsets.only(left: 10, top: 12.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: BasicText(
                            title: "Select Block",
                            fontSize: 16.5,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: DropdownButtonFormField2<String>(
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              enabled: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 15),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(15.4),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.4),
                              ),
                            ),
                            hint: const Text(
                              'Select Block',
                              style: TextStyle(fontSize: 14),
                            ),
                            value: selectedvalue,
                            items: blocknames!
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item.toString(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400, fontSize: 18),
                              ),
                            ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select block.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedvalue = value.toString();
                                _fetchUsers(); // Fetch users again when value changes
                              });
                            },
                            onSaved: (value) {
                              selectedvalue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.only(right: 8),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              iconSize: 25,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              elevation: 12,
                              maxHeight: MediaQuery.of(context).size.height / 2.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),

          ],
        ),
      ),
    );
  }

   _fetchUsers() {

   }
}
