import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
  Future<List<ExpenseRequest>?>? futureUsers;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  var remarks = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(12.5),
        child: ListView(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          children: [
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
                                _fetchUsers(); // Fetch users when a new block is selected
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
            selectedvalue != null ? FutureBuilder<List<ExpenseRequest>?>(
              future: ApiService().getExpenseusers(selectedvalue, widget.apartid, "Pending"),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
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
                        return _buildListItem(context, index, expenses!, animation);
                      },
                    ),
                  );
                }
                return Container();
              },
            ) : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index, List<ExpenseRequest> expenses, Animation<double> animation) {
    if (index >= expenses.length) {
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
                      Users? user = await ApiService.userData(expenses[index].userId!);
                      userPop(user!);
                    },
                    icon: Icon(
                      Icons.info,
                      color: Colors.orangeAccent.shade700,
                      size: 26,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BasicText(
                      title: "Amount : -",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    BasicText(
                      title: "${expenses[index].amount} Rs",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BasicText(
                      title: "Expense type : -",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    BasicText(
                      title: "${expenses[index].expenseType} ",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12.5),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BasicText(
                      title: "Expense Date : -",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    BasicText(
                      title: "${getdate(expenses[index].expenseDate)} Rs",
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4.3, bottom: 12.3),
                ),
                buildbuttons(expenses, index),
                const SizedBox(height: 10),
              ],
            ),
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
                _buildDetailRow("Block Name:", user.block_name!),
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

  String getdate(String? expenseDate) {
    DateTime dateTime = DateTime.parse(expenseDate!);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }

  void _removeItem(int index, List<ExpenseRequest> expenses) {
    final removedItem = expenses[index];

    setState(() {
      expenses.removeAt(index);
    });

    _listKey.currentState!.removeItem(
      index,
          (context, animation) => _buildListItem(context, index, [removedItem], animation),
      duration: const Duration(milliseconds: 300),
    );

    if (expenses.isEmpty) {
      _fetchUsers(); // Refresh users if the list becomes empty
    }
  }
  void _fetchUsers() {
    futureUsers = ApiService().getExpenseusers(selectedvalue, widget.apartid, "Pending");
    futureUsers!.then((value) {
      setState(() {
        expenses = value;
        itemcount = expenses!.length;
        _listKey.currentState?.setState(() {}); // Refresh the list view
        print("Fetched ${expenses!.length} expense requests"); // Debug logging
      });
    }).catchError((error) {
      print("Error fetching users: $error");
      setState(() {
        expenses = [];
        itemcount = 0;
      });
    });
  }

  Widget buildbuttons(List<ExpenseRequest> expenses, int index) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: [
            if (expenses[index].ispressed ?? false) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: remarks,
                  decoration: InputDecoration(
                    hintText: "Enter remarks",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  // Add your decline logic here
                  _removeItem(index, expenses);
                },
                child: Text(
                  "Submit",
                  style: GoogleFonts.acme(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ] else ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      // Add your approve logic here
                      print("Approved: ${expenses[index].userId}");
                      _removeItem(index, expenses);
                    },
                    child: Text(
                      "Approve",
                      style: GoogleFonts.acme(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 14.3),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      onPressed: () {
                        setState(() {
                          expenses[index].ispressed = true;
                        });
                      },
                      child: Text(
                        "Decline",
                        style: GoogleFonts.acme(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
