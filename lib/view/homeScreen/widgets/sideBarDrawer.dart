import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/addVehicleScreen/addVehicle.dart';
import 'package:vcharge/view/faqScreen/faqScreen.dart';
import 'package:vcharge/view/helpSupportScreen/helpSupportScreen.dart';
import 'package:vcharge/view/walletScreen/walletScreen.dart';

import '../../referFriendScreen/referFriend.dart';

class SideBarDrawer extends StatefulWidget {

  String userId;

  SideBarDrawer({super.key, required this.userId});

  @override
  State<SideBarDrawer> createState() => _SideBarDrawerState();
}

class _SideBarDrawerState extends State<SideBarDrawer> {


  // variables for storing the only displaying user details
  String firstName = '';
  String lastName = '';
  var profilePhoto = '';


String specificUserIdUrl = "http://192.168.0.41:8081/manageUser/user?userId=USR20230410143236933";




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
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    // ],
                    ),
                child: const FaIcon(FontAwesomeIcons.car,size: 20,color: Color.fromARGB(255, 51, 50, 50),),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Add Vehicle'),
                      onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddVehicleScreen())
                      ).then((value) {
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pop(context); // Close the drawer smoothly
                        });
                      });
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
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    // ],
                    ),
                child: const Icon(Icons.wallet),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Wallet'),
                      onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletScreen(userId: widget.userId,))
                      ).then((value) {
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pop(context); // Close the drawer smoothly
                        });
                      });
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
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    // ],
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
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    // ],
                    ),
                child: const Icon(Icons.favorite_outline_outlined),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Favourites'),
                      onTap: () {
              Navigator.pop(context);
                      },
                    ),
            ),
          ],
        ),


        // container
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Container(
                decoration: const BoxDecoration(
                    // border: Border.all(),
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    // ],
                    ),
                child: const Icon(Icons.child_friendly),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Refer a friend'),
                      onTap: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReferFriend())
                      ).then((value) {
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pop(context); // Close the drawer smoothly
                        });
                      });
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
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    // ],
                    ),
                child: const Icon(Icons.question_answer),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('FAQ'),
                      onTap: () {
              // Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const FaqScreen())
              //         ).then((value) {
              //           Future.delayed(const Duration(milliseconds: 250), () {
              //             Navigator.pop(context); // Close the drawer smoothly
              //           });
              //         });
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
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    // ],
                    ),
                child: const Icon(Icons.headphones),
              ),
            ),
            Expanded(
              child: ListTile(
                      title: const Text('Help & Support'),
                      onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HelpSupportScreen())
                      ).then((value) {
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.pop(context); // Close the drawer smoothly
                        });
                      });
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
                    // boxShadow: [
                    //   BoxShadow(
                    //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    // ],
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