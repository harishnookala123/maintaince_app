import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/Admin/Model/adminRegistartion.dart';
import 'package:maintaince_app/Admin/Views/userdetails.dart';
import 'package:maintaince_app/Admin/changeprovider/api.dart';
import 'package:maintaince_app/styles/basicstyles.dart';

import '../../Co_admin/Views/registration.dart';
import '../../login.dart';
import '../Model/bills.dart';
import 'maintaince_bill.dart';

class BuildDrawer extends StatefulWidget {
  final Admin? userdetails;
  final String? userid;

  const BuildDrawer({super.key, this.userdetails, this.userid});

  @override
  State<BuildDrawer> createState() => BuildDrawerState();
}

class BuildDrawerState extends State<BuildDrawer> {
  @override
  Widget build(BuildContext context) {
    Admin? admin = widget.userdetails;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF0099CC),
            ),
            accountName: Text(
              "${admin?.firstName ?? ''} ${admin?.lastName ?? ''}",
              style: GoogleFonts.poppins(
                fontSize: getFontSize(context, 20),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              admin?.email ?? '',
              style: GoogleFonts.poppins(
                fontSize: getFontSize(context, 14),
                color: Colors.white70,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.perm_identity_sharp,
                size: screenWidth * 0.1,
                color: Colors.pinkAccent.shade200,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.request_page,
              color: Colors.pinkAccent.shade200,
              size: screenWidth * 0.07,
            ),
            title: Text(
              "User Requests",
              style: GoogleFonts.poppins(
                fontSize: getFontSize(context, 16),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserDetails(userid: widget.userid)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.receipt_long,
              color: Colors.pinkAccent.shade200,
              size: screenWidth * 0.07,
            ),
            title: Text(
              "Set Maintenance Bills",
              style: GoogleFonts.poppins(
                fontSize: getFontSize(context, 16),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () async {
              var apartmentcode = widget.userdetails!.apartmentCode;

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MaintainceBill(
                      apartcode: apartmentcode, userid: widget.userid)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.group_add,
              color: Colors.pinkAccent.shade200,
              size: screenWidth * 0.07,
            ),
            title: Text(
              "Add Co-Admin",
              style: GoogleFonts.poppins(
                fontSize: getFontSize(context, 16),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CoRegistration(adminId: widget.userid, admin: admin)));
            },
          ),
          const SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Login()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      maximumSize: const Size(150, 100),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(19), // Rounded corners
                      ),
                      elevation: 7, // Elevation
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: getFontSize(context, 24),
                        ), // Prefix icon
                        const SizedBox(
                            width: 10), // Space between icon and text
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: getFontSize(context, 20),
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
