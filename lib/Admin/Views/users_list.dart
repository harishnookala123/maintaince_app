import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/basicstyles.dart';
import '../Model/usermodel.dart';
import '../changeprovider/api.dart';

class Userlist extends StatefulWidget {
  final String? apartid;
  const Userlist({super.key, this.apartid});

  @override
  State<Userlist> createState() => _UserlistState();
}

class _UserlistState extends State<Userlist> {
  Future<List<Users>?>? futureUsers;
  List<Users>? users;
  int? itemcount;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  String? selectedvalue;

  @override
  void initState() {
    _fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0099CC),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF003366),
        title: Text(
          "User List",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF003366), // Darker blue color at the top
              Color(0xFF0099CC), // Lighter blue color at the bottom
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 15),
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
                          margin: const EdgeInsets.only(bottom: 2.6),
                          alignment: Alignment.topLeft,
                          child: BasicText(
                            title: "Select Block",
                            fontSize: 16.5,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.4,
                          child: DropdownButtonFormField2<String>(
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white, width: 2.0),
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
                              style: TextStyle(fontSize: 14,
                               color: Colors.white
                              ),
                            ),

                            value: selectedvalue,
                            items: blocknames!
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item.toString(),
                                style: GoogleFonts.poppins(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                    fontSize: getFontSize(context, 19)
                                ),
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
                                color: Colors.white,
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
            selectedvalue != null
                ? Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const ScrollPhysics(),
                children: [
                  FutureBuilder<List<Users>?>(
                    future: futureUsers,
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
                        users = snap.data;
                        itemcount = users!.length;
                        return Container(
                          margin: const EdgeInsets.all(12.3),
                          child: AnimatedList(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            key: _listKey,
                            initialItemCount: itemcount!,
                            itemBuilder: (context, index, animation) {
                              return _buildListItem(
                                context,
                                index,
                                users!,
                                animation,
                              );
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index, List<Users> users, Animation<double> animation) {
    if (index >= users.length) {
      return Container(); // Return an empty container if the index is out of bounds
    }

    return FadeTransition(
      opacity: animation,
      child: Column(
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
                      Users? user = await ApiService.userData(users[index].uid!);
                      userPop(user!);
                    },
                    icon: const Icon(
                      Icons.info,
                      color: Colors.orangeAccent,
                      size: 26,
                    ),
                  ),
                ),
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
                      title: users[index].first_name!,
                      color: Colors.black,
                      fontSize: 15.5,
                    ),
                  ],
                ),
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
                    BasicText(
                      title: users[index].block_name!.toUpperCase(),
                      color: Colors.black,
                      fontSize: 15.5,
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
                    BasicText(
                      title: users[index].flat_no!,
                      color: Colors.black,
                      fontSize: 15.5,
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.4),
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

  void _fetchUsers() {
    futureUsers = ApiService().getUsers(widget.apartid!, "Approved", selectedvalue);
    futureUsers!.then((value) {
      setState(() {
        users = value;
        itemcount = users!.length;
      });
    }).catchError((error) {
      print("Error fetching users: $error");
      setState(() {
        users = [];
        itemcount = 0;
      });
    });
  }
}
