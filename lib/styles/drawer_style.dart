import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 100, // Decrease the height
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  SizedBox(width: 8.0), // Add some spacing between the icon and the text
                  Text(
                    'Username',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
              // Handle navigation to Info
            },
          ),
        ],
      ),
    );
  }
}
