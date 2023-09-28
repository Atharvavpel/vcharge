import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcharge/view/addVehicleScreen/addVehicle.dart';
import 'package:vcharge/view/faqScreen/faqScreen.dart';
import 'package:provider/provider.dart';
import 'package:vcharge/view/settingScreen/settingPage.dart';
import 'package:vcharge/view/helpSupportScreen/helpSupportScreen.dart';
import 'package:vcharge/view/settingScreen/settingPage.dart';
import 'package:vcharge/view/walletScreen/walletScreen.dart';
import '../../favouriteScreen/favouriteScreen.dart';
import '../../referFriendScreen/referFriend.dart';
import '../../reservationsScreen/reservationScreen.dart';

// ignore: must_be_immutable
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
  String contactNo = '';
  String emailId = '';

  String specificUserIdUrl =
      "http://192.168.0.243:8097/manageUser/user?userId=USR20230517060841379";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
// this mediaQuery is used to make the drawer responsive
      width: MediaQuery.of(context).size.width * 0.75,
      child: Semantics(
        label: "drawerButton",
        value: 'drawerButton',
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
                  child: Icon(
                    Icons.person,
                    size: 70,
                    color: Colors.black,
                  ),
                ),
              ),

              // this is the real widget for displaying the list of items

              // container - vehicle addition
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: const FaIcon(
                          FontAwesomeIcons.car,
                          size: 20,
                          color: Colors.green,
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
                                  builder: (context) => AddVehicleScreen(
                                        userId: widget.userId,
                                      ))).then((value) {
                            Future.delayed(
                              const Duration(milliseconds: 250),
                            );
                          });
                        },
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // container - wallet
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            // border: Border.all(),
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                            // ],
                            ),
                        child: const Icon(
                          Icons.wallet,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Wallet'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WalletScreen(
                                        userId: widget.userId,
                                      ))).then((value) {
                            Future.delayed(
                              const Duration(milliseconds: 250),
                            );
                          });
                        },
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // container - reservation
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            // border: Border.all(),
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                            // ],
                            ),
                        child: const Icon(
                          Icons.book_online,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Reservations'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReservationScreen(
                                        userId: widget.userId,
                                      ))).then((value) {
                            Future.delayed(
                              const Duration(milliseconds: 250),
                            );
                          });
                        },
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Container - favourites
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            // border: Border.all(),
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                            // ],
                            ),
                        child: const Icon(
                          Icons.favorite_outline_outlined,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Favourites'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FavouriteSceen(
                                      userId: widget.userId))).then((value) {
                            Future.delayed(
                              const Duration(milliseconds: 250),
                            );
                          });
                        },
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // container for Refer a friend
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            // border: Border.all(),
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                            // ],
                            ),
                        width: 25,
                        height: 25,
                        child: Image.asset("assets/images/referral.png",
                            color: Colors.green),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Refer a friend'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ReferFriend())).then((value) {
                            Future.delayed(
                              const Duration(milliseconds: 250),
                            );
                          });
                        },
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // container - FAQ
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(
                            // border: Border.all(),
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                            // ],
                            ),
                        child: const Icon(Icons.question_answer,
                            color: Colors.green),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('FAQ'),
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FaqScreen()))
                              .then((value) {
                            Future.delayed(
                              const Duration(milliseconds: 250),
                            );
                          });
                        },
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // container - help and support
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child:
                            const Icon(Icons.headphones, color: Colors.green),
                      ),
                    ),
                    Expanded(
                      child: Semantics(
                        label: "drawerHelpAndSupportButton",
                        child: ListTile(
                          title: const Text('Help & Support'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HelpSupportScreen(
                                          userId: widget.userId,
                                        )));
                            Future.delayed(
                              const Duration(milliseconds: 250),
                            );
                          },
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: MediaQuery.of(context).size.width * 0.07,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Container - settings page
              Container(
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 0.1))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: const Icon(Icons.settings, color: Colors.green),
                      ),
                    ),
                    Expanded(
                      child: Semantics(
                        label: "drawerSettingsButton",
                        child: ListTile(
                          title: const Text('Settings'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingPage(
                                  userId: widget.userId.toString(),
                                  firstNameEdited: firstName,
                                  lastNameEdited: lastName,
                                  contactNoEdited: contactNo,
                                  emailIdEdited: emailId,
                                ),
                              ),
                            ).then((value) {
                              Future.delayed(
                                const Duration(milliseconds: 250),
                              );
                            });
                          },
                          trailing: Icon(
                            Icons.keyboard_arrow_right,
                            size: MediaQuery.of(context).size.width * 0.07,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // container - logout
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 20.0),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: const Icon(Icons.logout, color: Colors.red),
                    ),
                  ),
                  Expanded(
                    child: Semantics(
                      label: "drawerLogoutButton",
                      child: ListTile(
                        title: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {},
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: MediaQuery.of(context).size.width * 0.07,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
