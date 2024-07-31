import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maintaince_app/User/Views/management_info.dart';
import 'package:maintaince_app/styles/basicstyles.dart';
import '../Admin/Model/usermodel.dart';
import '../User/Views/user_infoscreen.dart';
import '../login.dart';

class CustomDrawer extends StatefulWidget {
  final Users? user;

  CustomDrawer({Key? key, this.user}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF0099CC),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                  ),
                ),
                accountName: Text(
                  widget.user?.first_name ?? 'User Name',
                  style: GoogleFonts.poppins(
                    fontSize: getFontSize(context, 20),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  widget.user?.email ?? 'user@example.com',
                  style: GoogleFonts.poppins(
                    fontSize: getFontSize(context, 14),
                    color: Colors.white,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.perm_identity_sharp,
                    size: getFontSize(context, 40),
                    color: Colors.pinkAccent.shade200,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(Icons.edit, color: Colors.blue.shade400),
                    title: Text(
                      'Edit Profile',
                      style: GoogleFonts.poppins(
                        fontSize: getFontSize(context, 16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      // Handle navigation to Edit Profile
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.blue.shade400),
                    title: Text(
                      'Info',
                      style: GoogleFonts.poppins(
                        fontSize: getFontSize(context, 16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoScreen(user: widget.user),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.blue.shade400),
                    title: Text(
                      'Management Info',
                      style: GoogleFonts.poppins(
                        fontSize: getFontSize(context, 16),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManagementInfoScreen(user: widget.user),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  const SizedBox(height: 20.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2.3,
                        height: 70,
                        child: Align(
                          //alignment: Alignment.bottomRight,
                          child: Container(
                            // alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context,
                                 MaterialPageRoute(builder: (context)=>const Login())
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), // Rounded corners
                                ),
                                elevation: 7, // Elevation
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.logout, color: Colors.red, size: 24), // Prefix icon
                                  const SizedBox(width: 10), // Space between icon and text
                                  Text(
                                    "Logout",
                                    style: TextStyle(fontSize:getFontSize(context, 18),color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
