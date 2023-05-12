import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcharge/utils/providers/darkThemeProvider.dart';
import 'package:vcharge/view/passwordScreen/changePasswordScreen.dart';
import 'package:vcharge/view/profileScreen/editProfileScreen.dart';

// ignore: must_be_immutable
class SettingPage extends StatefulWidget {


  String userId;
  String? firstNameEdited;
  String? lastNameEdited;
  String? emailIdEdited;
  String? contactNoEdited;

  SettingPage({super.key, 
  
                    required this.userId,
                    required this.firstNameEdited,
                    required this.lastNameEdited,
                    required this.contactNoEdited,
                    required this.emailIdEdited,
                    });

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  // variable for tracking dark mode status
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {

    // var for updating the dark and light mode upon certain condition
    final themeChanger = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Settings"),
        ),
        body: Column(children: [


// profile section
          Container(
            width: double.infinity,
            color: Colors.green.shade200,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
              child: Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),
          ),

// edit profile button
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.1))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                onTap: () {
                  setState(() {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => EditProfileScreen(userId: widget.userId.toString(),
                          firstNameEdited: widget.firstNameEdited.toString(),
                          lastNameEdited: widget.lastNameEdited.toString(),
                          emailIdEdited: widget.emailIdEdited.toString(),
                          contactNoEdited: widget.contactNoEdited.toString(),
                        ))),
                  );
                  });
                  
                },
                title: const Text(
                  "Edit Profile",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                leading: const Icon(Icons.edit,),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
            ),
          ),

// change password
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.1))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                onTap: () {
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> ChangePasswordScreen(
                      emailId: widget.emailIdEdited.toString()
                    ) )
                  );
                },
                title: const Text(
                  "Change Password",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                leading: const Icon(Icons.lock_open),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
            ),
          ),

// notifications section
          Container(
            width: double.infinity,
            color: Colors.green.shade200,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),
          ),
// notificaton preference container
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.1))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                onTap: () {},
                title: const Text(
                  "Notifications Preferences",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                leading: const Icon(Icons.notification_important),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
            ),
          ),

// languages section
          Container(
            width: double.infinity,
            color: Colors.green.shade200,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
              child: Text(
                "Regional",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),
          ),
// choose languages container
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.1))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                onTap: () {},
                title: const Text(
                  "Languages",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                leading: const Icon(Icons.language),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
            ),
          ),

// actions section
          Container(
            width: double.infinity,
            color: Colors.green.shade200,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, bottom: 5),
              child: Text(
                "Actions",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),
          ),
          
// Delete container
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.1))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                onTap: () {},
                title: const Text(
                  "Delete my Account",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                leading: const Icon(Icons.delete),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
            ),
          ),

// logout button
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.1))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                onTap: () {},
                title: const Text(
                  "Logout",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                leading: const Icon(Icons.logout),
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                  size: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
            ),
          ),

// dark mode button
          Container(
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(width: 0.1))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: ListTile(
                  onTap: () {},
                  title: const Text(
                    "Dark Mode",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                  ),
                  leading: const Icon(Icons.dark_mode),
                  trailing: Switch(
                    value: isDarkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        isDarkModeEnabled = value;
                        isDarkModeEnabled
                            ? themeChanger.setTheme(ThemeMode.dark)
                            : themeChanger.setTheme(ThemeMode.light);
                      });
                    },
                  )),
            ),
          ),
        ]));
  }
}
