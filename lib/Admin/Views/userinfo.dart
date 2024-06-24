import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../styles/basicstyles.dart';
import '../Model/usermodel.dart';
import '../changeprovider/api.dart';

class Userinfo extends StatefulWidget {
  String? apartid;
  Userinfo({super.key, this.apartid});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  Future<List<Users>?>? futureUsers;
  @override
  void initState() {
    futureUsers = ApiService().getUsers(widget.apartid!, "Approved");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Users>?>(
        future: futureUsers,
        builder: (context, snap) {
          if (snap.hasData) {
            var users = snap.data;
            return Container(
              child: users!.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.all(12.3),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: users.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    buildCard(users, index),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ],
                                );
                              })
                        ],
                      ),
                    )
                  : Center(
                      child: BasicText(
                        title: "No Accept Requests",
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

  buildCard(List<Users> users, int index) {
    return Card(
      elevation: 6.0,
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
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
