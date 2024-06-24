import 'package:flutter/cupertino.dart';
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

  @override
  void initState() {
    super.initState();
    futureUsers = ApiService().getUsers(widget.apartid!, "Pending");
    print(futureUsers);
  }

  void refreshUsers() {
    setState(() {
      futureUsers = ApiService().getUsers(widget.apartid!, "Pending");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Users>?>(
        future: futureUsers,
        builder: (context, snap) {
          if (snap.hasData) {
            var users = snap.data;
            print(users);
            return Container(
              margin: const EdgeInsets.all(12.3),
              child: users!.isNotEmpty
                  ? AnimatedList(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  key: _listKey,
                  initialItemCount: users.length,
                  itemBuilder: (context, index, animation) {
                    return _buildListItem(context, index, users, animation);
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
    );
  }

  Widget _buildListItem(BuildContext context, int index, List<Users> users,
      Animation<double> animation) {
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
                      Users user = await ApiService.userData(users[index].id!);
                      userPop(user);
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
                      title: users[index].userName!,
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
                      title: users[index].flatNo!,
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
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: BasicText(
                          title: users[index].appartName!,
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
                          users[index].id!,
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
                            users[index].id!,
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

  void _removeItem(int index, List<Users> users) {
    final removedUser = users[index];
    _listKey.currentState!.removeItem(
      index,
          (context, animation) => _buildListItem(context, index, [removedUser], animation),
      duration: const Duration(milliseconds: 2),
    );
    setState(() {
      users.removeAt(index);
    });

    if (users.isEmpty) {
      refreshUsers();
    }
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
                _buildDetailRow("User Name: ", user.userName!),
                _buildDetailRow("Phone Number:", user.mobileNum!),
                _buildDetailRow("Apart Name:", user.appartName!),
                _buildDetailRow("Flat No:", user.flatNo!),
                _buildDetailRow("Email:", user.emailId!),
                _buildDetailRow("User Type:", user.userType!),
                _buildDetailRow("Address:", user.permenantAddress!),
                _buildDetailRow("Apart ID:", user.apartId!),
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
