import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'drawer_items.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({Key? key}) : super(key: key);

  final List<DrawerItem> drawerItems = [
    const DrawerItem(icon: Icons.home, title: 'Home'),
    const DrawerItem(icon: Icons.settings, title: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Don Puerto"),
            accountEmail: Text("$userEmail"),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/DPLogo.png"),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            margin: EdgeInsets.zero,
            arrowColor: Colors.white,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(drawerItems[index].icon),
                  title: Text(drawerItems[index].title),
                  onTap: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text('Current User ID: $userId'),
            onTap: () {
              // Add your logout logic here
            },
          ),
        ],
      ),
    );
  }
}
