import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/addVehicleScreen/addVehicle.dart';
import 'package:vcharge/view/helpSupportScreen/helpSupportScreen.dart';
import 'package:vcharge/view/referFriendScreen/referFriend.dart';

class SideBarDrawer extends StatefulWidget {
  String userId;
  SideBarDrawer({super.key, required this.userId});

  @override
  State<SideBarDrawer> createState() => _SideBarDrawerState();
}

class _SideBarDrawerState extends State<SideBarDrawer> {
  String? firstName;
  String? lastName;
  String? userGender;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

// function for fetching specific user data
  Future<void> getUserData() async {
    var data = await GetMethod.getRequest(
        "http://192.168.0.41:8081/manageUser/user?userId=USR20230410143236933");

    if (data != null) {
      setState(() {
        firstName = data['userFirstName'] ?? '';
        lastName = data['userLastName'] ?? '';
        userGender = data['userGender'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("The button is tapped");
    return SizedBox(
// this mediaQuery is used to make the drawer responsive
      width: MediaQuery.of(context).size.width * 0.60,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
// this is the drawer header for the sidebar
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03,),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            // width: MediaQuery.of(context).size.width* 0.35,
                            // height: MediaQuery.of(context).size.height* 0.35,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      5.0,
                                      5.0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                                image: const DecorationImage(
                                    image: NetworkImage(
                                        "https://i.ibb.co/72mwSwS/WIN-20230410-18-16-42-Pro.jpg"),
                                    fit: BoxFit.cover),
                                shape: BoxShape.rectangle,
                                color: const Color(0xffD6D6D6)),
                          ),
                        ),
                      ),
                      userGender == "female"
                          ? Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
                            child: Container(
                                child: Text(" $firstName $lastName"),
                              ),
                          )
                          : Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.03),
                            child: Container(
                                child: Text(" $firstName $lastName"),
                              ),
                          )
                    ],
                  )),
            ),

// this is the real widget for displaying the list of items

// container - vehicle addition

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
                    child: const FaIcon(
                      FontAwesomeIcons.car,
                      size: 20,
                      color: Color.fromARGB(255, 51, 50, 50),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Add Vehicle'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddVehicleScreen()),
                      ).then((value) {
                        Future.delayed(Duration(milliseconds: 250), () {
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
                    child: const Icon(Icons.wallet),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Wallet'),
                    onTap: () {
                      Navigator.pop(context);
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
                    child: const Icon(Icons.book_online),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Reservations'),
                    onTap: () {
                      Navigator.pop(context);
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

            // container for refer a friend
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Container(
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
                    child: const Icon(Icons.question_answer),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('FAQ'),
                    onTap: () {
                      Navigator.pop(context);
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
                    child: const Icon(Icons.logout),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Logout'),
                    onTap: () {
                      Navigator.pop(context);
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
