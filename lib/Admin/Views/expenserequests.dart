import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/expenserequest.dart';

import '../../styles/basicstyles.dart';
import '../Model/usermodel.dart';
import '../changeprovider/api.dart';
class Expenserequests extends StatefulWidget {
  String? apartid;
  Expenserequests({super.key, this.apartid});

  @override
  State<Expenserequests> createState() => _ExpenserequestsState();
}

class _ExpenserequestsState extends State<Expenserequests> {
  String? selectedvalue;
  List<ExpenseRequest>? expenses;
  int? itemcount;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(12.5),
        child: Column(
          children: [
            const SizedBox(height: 30,),
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
            const SizedBox(height: 10,),
            selectedvalue!=null?FutureBuilder<List<ExpenseRequest>?>(
              future: ApiService().getExpenseusers(selectedvalue, widget.apartid, "Pending"),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                } else if (snap.hasError) {
                  return Center(
                    child: Text("Error: ${snap.error}"),
                  );
                } else if (snap.hasData && snap.data!.isEmpty) {
                  return Center(
                    child: BasicText(
                      title: "No Pending Requests",
                      color: Colors.black,
                      fontSize: 14.5,
                    ),
                  );
                } else if (snap.hasData && snap.data!.isNotEmpty) {
                  expenses = snap.data;
                  itemcount = expenses!.length;
                  return Container(
                    margin: const EdgeInsets.all(12.3),
                    child: AnimatedList(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      key: _listKey,
                      initialItemCount: itemcount!,
                      itemBuilder: (context, index, animation) {
                        return _buildListItem(context, index, expenses!, animation,);
                      },
                    ),
                  );
                }
                return Container();
              },
            ):Container(),

          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index, List<ExpenseRequest> users,
      Animation<double> animation) {
    if (index >= users.length) {
      return Container(); // Return an empty container if the index is out of bounds
    }
    return FadeTransition(
      opacity: animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            elevation: 3.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.5),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () async {
                      Users? user = await ApiService.userData(users[index].userId!);
                      userPop(user!);
                    },
                    icon:  Icon(
                      Icons.info,
                      color: Colors.orangeAccent.shade700,
                      size: 26,
                    ),
                  ),
                ),
                FutureBuilder<Users?>(
                    future:ApiService.userData(expenses![index].userId!) ,
                    builder: (context,snap){
                      if(snap.hasData){
                        var user = snap.data;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: BasicText(
                                    title: "Name : - ",
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                BasicText(
                                  title: user!.first_name!,
                                  color: Colors.black,
                                  fontSize: 15.5,
                                ),
                              ],
                            ),
                            Container(
                               margin: const EdgeInsets.only(top: 12.5),
                            )
                          ],
                        );

                      }else{
                        return Container();
                      }
                    }),
                Container(
                  margin: const EdgeInsets.only(top: 12.4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: BasicText(
                        title: "Block : -",
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),

                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BasicText(
                      title: "Flat No : -",
                      color: Colors.black,
                      fontSize: 16,
                    ),

                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.4),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BasicText(
                      title: "Apartment : -",
                      color: Colors.black,
                      fontSize: 16,
                    ),

                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                ),

                const SizedBox(height: 10),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );

  }
  userPop(Users user) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "User Details",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("User Name: ", user.first_name!),
                _buildDetailRow("Phone Number:", user.phone!),
                _buildDetailRow("Apart Name:", user.apartment_name!),
                _buildDetailRow("Block Name", user.block_name!),
                _buildDetailRow("Flat No:", user.flat_no!),
                _buildDetailRow("Email:", user.email!),
                _buildDetailRow("User Type:", user.user_type!),
                _buildDetailRow("Address:", user.address!),
                _buildDetailRow("Apart ID:", user.apartment_code!),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120, // Fixed width for the label
            child: Text(
              label,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: BasicText(
              title: value,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
