import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcharge/view/addVehicleScreen/addVehicle.dart';

class SideBarDrawer extends StatelessWidget {
  const SideBarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

// this mediaQuery is used to make the drawer responsive
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
      child: ListView(
      padding: EdgeInsets.zero,
      children: [

// this is the drawer header for the sidebar
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 70, color: Colors.black,),
          ),
        ),


// this is the real widget for displaying the list of items



// container - vehicle addition

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
                child: const FaIcon(FontAwesomeIcons.car,size: 20,color: Color.fromARGB(255, 51, 50, 50),),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Add Vehicle'),
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVehicleScreen()));
                      },
                    ),
            ),
          ],
        ),
        

// container - wallet
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



// container - reservation
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



// container - FAQ
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


// container - help and support      
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


// container - logout
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