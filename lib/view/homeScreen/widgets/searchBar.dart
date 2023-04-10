import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/horizontalSideBar.dart';
import 'package:vcharge/view/profileScreen/myProfile.dart';

class SearchBarContainer extends StatefulWidget {

  String userId;


  SearchBarContainer({required this.userId ,super.key});

  @override
  State<SearchBarContainer> createState() => SearchBarContainerState();
}

class SearchBarContainerState extends State<SearchBarContainer> {
  String? searchQuery;

  void onSearchSubmitted(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  Widget searchBarContainer() {
    return SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 6),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    //drawer button
                    Builder(
                      builder: (context) => IconButton(
                        key: const Key('drawerButton'),
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                    // expanded for search text field
                    const Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: " Search here",
                          ),
                        ),
                      ),
                    ),

                    //Expanded for notification button
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        key: const Key('notificationButton'),
                        onPressed: () {
                        },
                        icon: const Icon(Icons.notifications),
                        iconSize: 30,
                      ),
                    ),

                    //Expanded for profile button
                    Expanded(
                      flex: 2,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyProfilePage()));
                        },
                        icon: const Icon(Icons.person),
                        iconSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // alternate side bar
            HorizontalSideBar(userId: widget.userId,),
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
