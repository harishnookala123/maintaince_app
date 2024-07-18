import 'package:flutter/material.dart';
import 'package:maintaince_app/User/Views/management_info.dart';
import '../Admin/Model/usermodel.dart';
import '../User/Views/user_infoscreen.dart';

class CustomDrawer extends StatelessWidget {
  final Users? user;

  CustomDrawer({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.shade400,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 50.0,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.first_name ?? 'User Name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            user?.email ?? 'user@example.com',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.5,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.blue),
            title: const Text(
              'Edit Profile',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            onTap: () {
              // Handle navigation to Edit Profile
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text(
              'Info',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.blue),
            title: const Text(
              'Management Info',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
