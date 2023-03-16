import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 15, 15, 15),
                    color: Color.fromARGB(0, 11, 10, 10),
                  ),
                  child: Text(
                    'My Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: const Text('My Vechicle'),
                  onTap: () {
                    
                  },
                ),
                ListTile(
                  title: const Text('My Wallet'),
                  onTap: () {
                    // Do something
                  },
                ),
                ListTile(
                  title: const Text('Favourite'),
                  onTap: () {
                    // Do something
                  },
                ),
                ListTile(
                  title: const Text('Reservations'),
                  onTap: () {
                    // Do something
                  },
                ),
                ListTile(
                  title: const Text('More'),
                  onTap: () {
                    // Do something
                  },
                ),
              ],
            ),
          ),
    );
  }
}