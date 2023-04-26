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

  SearchBarContainer({required this.userId, required this.callBack,super.key});

  @override
  State<SearchBarContainer> createState() => SearchBarContainerState();
}

class SearchBarContainerState extends State<SearchBarContainer> {

  FocusNode? searchFocus;


  @override
  void initState() {
    super.initState();
    searchFocus = FocusNode();
  }


  dynamic keyStroke;

  dynamic searchData;

  Future<void> fetchData(String keyword) async {
    print("Entered the fetchData");
    String url =
        "http://192.168.0.43:8081/vst1/manageStation/search?query=$keyword";

        final response = await http.get(Uri.parse(url));
    
    setState(() {
      
      try {
      if (response.statusCode == 200) {
        setState(() {
          searchData = response.body;
          print("the searched data is: $searchData");
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print("the error is: $error");
    }


    });
    
  }

  dynamic searchBarContainer() {
    return SafeArea(
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
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
                  child: TextField(
                    key: const Key('searchBar'),
                    focusNode: searchFocus,
                    readOnly: true,

                    onTap: () {
                      showSearch(
                        context: context, 
                        delegate: SearchingWidget()
                      );
                    },

                    // onChanged: (value) {
                    //   showSearch(
                    //     context: context, 
                    //     delegate: SearchingWidget()
                    //   );
                    // },


                    




                    // onSubmitted: (value) {  
                    //   searchFocus!.unfocus();
                    // },
                    // onChanged: (value) => fetchData(value),
                    // onTap: (){
                    //   showBottomSheet(
                    //             context: context,
                    //             builder: (BuildContext context) {
                    //               return SearchingWidget();
                    //             });
                    // },
                    
                    decoration: InputDecoration(
          
                      // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: Get.width* 0.03),
                        child: IconButton(
                          key: const Key('drawerButton'),
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      hintText: "Search here",
                      
                      hintStyle: const TextStyle(color: Colors.black),
                      suffixIcon: SizedBox(
                        width: Get.width* 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              key: const Key('notificationButton'),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.notifications,
                                color: Colors.black,
                              ),
                              iconSize: Get.height * 0.036,
                            ),
                            IconButton(
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
                                color: Colors.black,
                              ),
                              iconSize: Get.height * 0.036,
                            ),
                          ],
                        ),
                      ),
                      
                    ),
                  ),
                )),
          ),

          // alternate side bar
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


/*


String? searchQuery = "http://192.168.0.43:8081/vst1/manageStation/search?q=";

TextField(
  onChanged: (String value) {
    // Concatenate the search query and the current search value
    String fullSearchQuery = searchQuery! + value;

    // Use the full search query to fetch the data
    fetchData(fullSearchQuery);
  },
  decoration: InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    enabledBorder: InputBorder.none,
    focusedBorder: InputBorder.none,
    prefixIcon: IconButton(
      key: const Key('drawerButton'),
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      onPressed: () => Scaffold.of(context).openDrawer(),
    ),
    suffixIcon: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          key: const Key('notificationButton'),
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          iconSize: Get.height * 0.036,
        ),
        IconButton(
          key: const Key('profileButton'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyProfilePage(
                  userId: widget.userId.toString()
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          iconSize: Get.height * 0.036,
        ),
      ],
    ),
    hintText: "Search here", 
    hintStyle: const TextStyle(
      color: Colors.black
    ),
  ),
);



*/











/*

// drawer button
                  IconButton(
                      key: const Key('drawerButton'),
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer()),

                  // expanded for search text field
                  // Expanded(
                  //   flex: 7,
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: 8),
                  //     child: TextField(
                  //       key: Key('searchTextField'),
                  //       decoration: InputDecoration(
                  //         border: InputBorder.none,
                  //         hintText: " Search here",
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: TextField(
                        key: Key('searchTextField'),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: " Search here",
                        ),
                        onChanged: (text) {
                          setState(() {
                            keyStroke = text;
                          });
                          
                          // make network call to fetch search results
                          final url = searchQuery!
                              .replaceAll('value_entered_by_user', keyStroke);
                          // use the url to fetch data using http or dio package
                          // update the search results in the state
                        },
                      ),
                    ),
                  ),

                  //Expanded for notification button
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      key: const Key('notificationButton'),
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                      iconSize: 30,
                    ),
                  ),

                  //Expanded for profile button
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      key: const Key('profileButton'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyProfilePage(
                                    userId: widget.userId.toString())));
                      },
                      icon: const Icon(Icons.person),
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),



*/