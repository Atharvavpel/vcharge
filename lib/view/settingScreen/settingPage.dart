import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vcharge/utils/providers/darkThemeProvider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Settings"),
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(children: [
              // profile section
              Container(
                color: Colors.green.shade200,
                child: const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: ListTile(
                      onTap: () {},
                      title: const Text("Edit Profile"),
                      trailing: const Icon(Icons.edit),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: ListTile(
                      onTap: () {},
                      trailing: const Icon(Icons.password),
                      title: const Text("Change Password"),
                    ),
                  ),
                ),
              ),

              // notifications section
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  color: Colors.green.shade200,
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        "Notifications",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: ListTile(
                      onTap: () {},
                      trailing: const Icon(Icons.edit_notifications),
                      title: const Text("Notifications Preferences"),
                    ),
                  ),
                ),
              ),

              // languages section
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  color: Colors.green.shade200,
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        "Regional",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: ListTile(
                      onTap: () {},
                      trailing: const Icon(Icons.language),
                      title: const Text("Languages"),
                    ),
                  ),
                ),
              ),

              // actions section
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  color: Colors.green.shade200,
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Center(
                      child: Text(
                        "Actions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: ListTile(
                      onTap: () {},
                      trailing: const Icon(Icons.delete_sharp),
                      title: const Text("Delete My Account"),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 13, right: 13),
                    child: ListTile(
                      onTap: () {},
                      trailing: const Icon(Icons.logout_sharp),
                      title: const Text("Logout"),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Card(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: ListTile(
                          title: const Text("Dark Mode"),
                          trailing: Switch(
                            value: isDarkModeEnabled,
                            onChanged: (value) {
                              setState(() {
                                print("The value of button is: $isDarkModeEnabled");
                                isDarkModeEnabled = value;
                                isDarkModeEnabled? themeChanger.setTheme(ThemeMode.dark) : themeChanger.setTheme(ThemeMode.light);
                              });
                            },
                          ))),
                ),
              ),
            ])));
  }
}
