import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';

import 'package:vcharge/view/homeScreen/widgets/bottomBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? searchQuery;
  bool _isVehicle = false;
  bool _isWallet = false;
  bool _isFavourite = false;
  bool _isReservation = false;
  bool _isMore = false;
  bool _locationFinder = false;

  @override
  void initState() {
    super.initState();
  }

  void onSearchSubmitted(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  Widget searchBarContainer() {
    return Container(
      child: SafeArea(
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
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    const Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications),
                        iconSize: 30,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          print("Profile image is being clicked");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 184, 181, 181),
                              radius: 15,
                              child: Icon(
                                Icons.person,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // alternate side bar
            sideBarAlternative(),
          ],
        ),
      ),
    );
  }

  Widget sideBarAlternative() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isVehicle = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    _isVehicle = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: _isVehicle ? Colors.blue : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.car_crash, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'My vechicle',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isWallet = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    _isWallet = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  // border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: _isWallet ? Colors.blue : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.wallet, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'My Wallet',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isFavourite = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    _isFavourite = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  // border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: _isFavourite ? Colors.blue : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'Favourite',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isReservation = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    _isReservation = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: _isReservation ? Colors.blue : Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.book_online, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'Reservations',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isMore = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    _isMore = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  // border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: _isMore ? Colors.blue : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.more, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'More',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Stack(children: [
        
        // background map
        BgMap(),

        // searchBar and navBar
        searchBarContainer(),

        // location finder
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(right: 13, bottom: 10),
              decoration: BoxDecoration(
                  color: _locationFinder ? Colors.blue : Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 10, color: Colors.grey, spreadRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(100)),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      _locationFinder = true;
                    });
                    Future.delayed(const Duration(seconds: 2)).then((_) {
                      setState(() {
                        _locationFinder = false;
                      });
                    });
                  },
                  icon: const Icon(
                    Icons.my_location,
                    size: 20,
                  )),
            )
          ),
          
        // Virtuoso logo
        Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              margin: const EdgeInsets.only(left: 13, bottom: 10),
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Image.asset("assets/images/logo.png"),
            )
          )

      ]),

      // bottom navigation bar
      bottomNavigationBar: Container(
        height: 71,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: const CustomBottomAppBar(),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          // shape: ,
          splashColor: Colors.black,
          backgroundColor: Colors.grey,

          onPressed: () {
            print("Onpressed on scanner");
          },
          child: const Icon(
            Icons.qr_code_scanner_sharp,
            size: 50,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
