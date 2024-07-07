import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import '../Model/usermodel.dart';

class PendingRequests extends StatefulWidget {
  final String? apartid;
  PendingRequests({super.key, this.apartid});

  @override
  State<PendingRequests> createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  Future<List<Users>?>? futureUsers;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  TextEditingController? remarks = TextEditingController();
  String? selectedvalue;

  int? itemcount;

  List<Users>? users;

  @override
  void initState() {
    print(widget.apartid);
    futureUsers = ApiService().getUsers(widget.apartid!, "Pending", selectedvalue);
    super.initState();
  }

  refreshUsers() {
    setState(() {
      futureUsers = ApiService().getUsers(widget.apartid!,"Pending",selectedvalue);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.apartid);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          FutureBuilder<List<String>?>(
            future: ApiService().getBlockName(widget.apartid),
            builder: (context, snap) {
              if (snap.hasData) {
                List<String>? blocknames = snap.data;
                return Container(
                  margin: const EdgeInsets.only(left: 25.5, top: 12.3),
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
                            contentPadding: const EdgeInsets.symmetric(vertical: 22),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(15.4),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.4)),
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
                              print("Selected block: $selectedvalue");
                              if(selectedvalue!=null){
                                print("dgd");
                                itemcount = 0;
                              }
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
          selectedvalue != null
              ? Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const ScrollPhysics(),
              children: [
                FutureBuilder<List<Users>?>(
                  future: ApiService().getUsers(widget.apartid!, "Pending", selectedvalue),
                  builder: (context, snap) {
                    if (snap.hasData) {
                       users = snap.data;
                       itemcount = users!.length;
                      print("Number of users: $itemcount");
                      return Container(
                        margin: const EdgeInsets.all(12.3),
                        child: users!.isNotEmpty
                            ? AnimatedList(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            key: _listKey,
                            initialItemCount: itemcount!,
                            itemBuilder: (context, index, animation) {
                              return _buildListItem(
                                  context, index, users!, animation);
                            })
                            : Center(
                          child: BasicText(
                            title: "No Pending Requests",
                            color: Colors.black,
                            fontSize: 14.5,
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
              : Container()
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index, List<Users> users,
      Animation<double> animation) {
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
                  margin: const EdgeInsets.all(12.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BasicText(
                        title: "Apart Name : - ",
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: BasicText(
                          title: users[index].apartment_name!,
                          color: Colors.black,
                          fontSize: 15.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                users[index].ispressed == false
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        await ApiService().updateApproval(
                          users[index].uid!,
                          "Approved",
                          "",
                        );
                        _removeItem(index, users);
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
                            users[index].ispressed = true;
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
                )
                    : Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.23,
                      child: Textfield(
                        controller: remarks,
                        keyboardType: TextInputType.multiline,
                        text: "Remarks",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Remarks";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(130, 50),
                          backgroundColor: Colors.green.shade400,
                        ),
                        onPressed: () async {
                          await ApiService().updateApproval(
                            users[index].uid!,
                            "Decline",
                            remarks!.text,
                          );
                          _removeItem(index, users);
                          setState(() {
                            remarks!.text = "";
                          });
                        },
                        child: BasicText(
                          title: "Submit",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
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

  void _removeItem(int index, List<Users> users) {
    final removedUser = users[index];
    _listKey.currentState!.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _buildListItem(context, index, [removedUser], animation),
      ),
      duration: const Duration(milliseconds: 300),
    );
    setState(() {
      users.removeAt(index);
    });

    if (users.isEmpty) {
      refreshUsers();
    }
  }
}
