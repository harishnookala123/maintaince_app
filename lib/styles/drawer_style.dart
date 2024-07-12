import 'package:flutter/material.dart';
import 'package:maintaince_app/User/Views/management_info.dart';

import '../Admin/Model/adminRegistartion.dart';
import '../Admin/Model/usermodel.dart';
import '../User/Views/user_infoscreen.dart';

class CustomDrawer extends StatelessWidget {
  final Users? user;


  CustomDrawer({super.key, this.user,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 100, // Decrease the height
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  const SizedBox(width: 8.0), // Add some spacing between the icon and the text
                  Text(
                    user!.first_name!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Decrease padding
            leading: const Icon(Icons.edit),
            title: const Text(
              'Edit Profile',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
            ),
            onTap: () {
              // Handle navigation to Edit Profile
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Decrease padding
            leading: const Icon(Icons.info),
            title: const Text(
              'Info',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfoScreen(user: user),
                ),
              );
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Decrease padding
            leading: const Icon(Icons.info),
            title: const Text(
              'Management Info',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
            ),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManagementInfoScreen(user: user),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
