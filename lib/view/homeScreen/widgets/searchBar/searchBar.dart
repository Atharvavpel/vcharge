import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcharge/view/homeScreen/widgets/horizontalSideBar.dart';
import 'package:vcharge/view/homeScreen/widgets/searchBar/searchingWidget.dart';
import 'package:vcharge/view/profileScreen/myProfile.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SearchBarContainer extends StatefulWidget {
  String userId;
  void callBack;

  SearchBarContainer({required this.userId, required this.callBack, super.key});

  @override
  State<SearchBarContainer> createState() => SearchBarContainerState();
}

class SearchBarContainerState extends State<SearchBarContainer> {
// focus node variable for implementing focus on searchbar
  FocusNode? searchFocus;

// init function calling the focusnode function
  @override
  void initState() {
    super.initState();
    searchFocus = FocusNode();
  }

// variable for storing the keystore characters while searching
  dynamic keyStroke;

// variable for storing the searchData - complete word or so
  dynamic searchData;

// function for finding relevant results against the searches
  Future<void> fetchData(String keyword) async {
    String url =
        "http://192.168.0.243:8096/vst1/manageStation/search?query=$keyword";

    final response = await http.get(Uri.parse(url));

    setState(() {
      try {
        if (response.statusCode == 200) {
          setState(() {
            searchData = response.body;
          });
        } else {
          throw Exception('Failed to load data');
        }
      } catch (error) {
        print("the error is: $error");
      }
    });
  }

// searchbar textfield having drawer, search textfied and notifications and profile icon
  dynamic searchBarContainer() {
    return SafeArea(
      child: Column(
        children: [
          // for unfocusing the taping gesture
          GestureDetector(
            onTap: () {
              searchFocus!.unfocus();
            },
            child: Padding(
                padding: EdgeInsets.only(
                    top: Get.height * 0.015,
                    left: Get.width * 0.03,
                    right: Get.width * 0.05,
                    bottom: Get.height * 0.005),
                child: Container(
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 2),
                    ],
                    borderRadius: BorderRadius.circular(Get.height * 0.01),
                    color: Colors.white,
                  ),

                  // main textfield for storing the different widgets
                  child: Semantics(
                    // label: "searchTextField",
                    // value: "searchTextField",
                    child: TextField(
                      key: const Key('searchBar'),
                      focusNode: searchFocus,
                      readOnly: true,

                      // function for calling the searching option - searchDelegate widget
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate: SearchingWidget(widget.userId));
                      },

                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,

                        // drawer button icon
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.03),
                          child: IconButton(
                            key: const Key('drawerButton'),
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.green,
                            ),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                        hintText: "Search here",

                        hintStyle: const TextStyle(color: Colors.black),

                        // notifications and profile icond
                        suffixIcon: SizedBox(
                          width: Get.width * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // notification icon button
                              Semantics(
                                // label: "notificationButton",
                                // value: "notificationButton",
                                child: IconButton(
                                  key: const Key('notificationButton'),
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.notifications,
                                    color: Colors.green,
                                  ),
                                  iconSize: Get.height * 0.036,
                                ),
                              ),

                              // profile icon button
                              Semantics(
                                // label: "profileButton",
                                // value: 'profileButton',
                                child: IconButton(
                                  key: const Key('profileButton'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyProfilePage(
                                            userId: widget.userId.toString()),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                  ),
                                  iconSize: Get.height * 0.036,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ),

          // sidebar below the searching widget or textfield
          HorizontalSideBar(
            userId: widget.userId,
          ),
        ],
      ),
    );
  }

// this is used to invoke the searchBarContainer()
  @override
  Widget build(BuildContext context) {
    return searchBarContainer();
  }
}
