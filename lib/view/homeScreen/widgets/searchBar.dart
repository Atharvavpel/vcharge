import 'package:flutter/material.dart';

class SearchBarContainer extends StatefulWidget {
  const SearchBarContainer({super.key});

  @override
  State<SearchBarContainer> createState() => _SearchBarContainerState();
}

class _SearchBarContainerState extends State<SearchBarContainer> {

 String? searchQuery;
  bool _isVehicle = false;
  bool _isWallet = false;
  bool _isFavourite = false;
  bool _isReservation = false;
  bool _isMore = false;
  

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
    return searchBarContainer();
  }
}