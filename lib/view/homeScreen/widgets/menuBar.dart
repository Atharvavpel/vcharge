import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideBarDrawer extends StatelessWidget {
  const SideBarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.60,
      // width: 30.w,
      child: Drawer(
      child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 70, color: Colors.black,),
          ),
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: const BoxDecoration(
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    ],
                    ),
                child: FaIcon(FontAwesomeIcons.car,size: 20,color: Color.fromARGB(255, 51, 50, 50),),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Add Vehicle'),
                      onTap: () {
              
                      },
                    ),
            ),
          ],
        ),
        
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: const BoxDecoration(
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    ],
                    ),
                child: const Icon(Icons.wallet),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Wallet'),
                      onTap: () {
              
                      },
                    ),
            ),
          ],
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: const BoxDecoration(
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    ],
                    ),
                child: const Icon(Icons.book_online),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Reservations'),
                      onTap: () {
              
                      },
                    ),
            ),
          ],
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: const BoxDecoration(
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    ],
                    ),
                child: const Icon(Icons.question_answer),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('FAQ'),
                      onTap: () {
              
                      },
                    ),
            ),
          ],
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: const BoxDecoration(
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    ],
                    ),
                child: const Icon(Icons.headphones),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Help & Support'),
                      onTap: () {
              
                      },
                    ),
            ),
          ],
        ),

        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: const BoxDecoration(
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    ],
                    ),
                child: const Icon(Icons.logout),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Logout'),
                      onTap: () {
              
                      },
                    ),
            ),
          ],
        ),

      ],
      ),
      ),
    );
  }
}