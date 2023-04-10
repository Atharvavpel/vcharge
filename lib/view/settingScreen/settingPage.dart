import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcharge/utils/providers/darkThemeProvider.dart';
import 'package:vcharge/view/profileScreen/editProfileScreen.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

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
          leading: IconButton(onPressed: (){

          }, icon: Icon(Icons.arrow_circle_left, 
          size: MediaQuery.of(context).size.width * 0.1,)),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const EditProfileScreen())),
                  );
                },
                title: const Text(
                  "Edit Profile",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
                // leading: const CircleAvatar(
                //   backgroundColor: Color.fromARGB(255, 245, 180, 82),
                //   child: Icon(Icons.edit, color: Colors.white,)),
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
                onTap: () {},
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
