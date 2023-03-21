import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';

import 'package:vcharge/view/homeScreen/widgets/locationFinder.dart';
import 'package:vcharge/view/homeScreen/widgets/virtuosoLogo.dart';
import 'package:vcharge/view/homeScreen/widgets/markerHints.dart';
import 'package:vcharge/view/homeScreen/widgets/searchBar.dart';
import 'package:vcharge/view/homeScreen/widgets/sideBarDrawer.dart';
import 'package:vcharge/view/listOfStations/listOfStations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// variable for filter button being pressed
  bool _isFilterOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// this variable is used to extend the backgroun
      extendBodyBehindAppBar: true,

// this is drawer function
      drawer: const SideBarDrawer(),

// used stack to display the widgets one above the other
      body: Stack(children: [
        // background map
        BgMap(),

        // searchBar and navBar
        const SearchBarContainer(),

        // location finder
        const Positioned(
          bottom: 0,
          right: 0,
          child: LocationFinder(),
        ),

        // Virtuoso logo
        const Positioned(
          bottom: 0,
          left: 0,
          child: VirtuosoLogo(),
        ),

        //Hint question Mark
        Positioned(
          bottom: 60,
          right: 0,
          child: MarkerHints(),
        ),
      ]),

      // bottom app bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey,
        animationDuration: const Duration(milliseconds: 300),
        items: <Widget>[
// button for home page
          const Icon(Icons.home, size: 30),

// button for qr code scanner
          const Icon(Icons.qr_code_scanner, size: 30),

// button for the list of stations
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListOfStations()));
              },
              child: const Icon(Icons.list, size: 30)),

// button for filter
          GestureDetector(
              onTap: () {
                setState(() {
                  _isFilterOpen = true;
                });
                
                _isFilterOpen == true ? showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterPopUp();
                    }) : [];
              },
              child: const Icon(Icons.filter_alt_sharp, size: 30)),
        ],
      ),

      // reserve this code for future reference:

      // bottom navigation bar
      // bottomNavigationBar: Container(
      //   height: 71,
      //   decoration: BoxDecoration(
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.white.withOpacity(0.5),
      //         spreadRadius: 2,
      //         blurRadius: 2,
      //         offset: const Offset(2, 2),
      //       ),
      //     ],
      //   ),
      //   child: const CustomBottomAppBar(),
      // ),
      // floatingActionButton: SizedBox(
      //   width: 70,
      //   height: 70,
      //   child: FloatingActionButton(
      //     // shape: ,
      //     splashColor: Colors.black,
      //     backgroundColor: Colors.grey,

      //     onPressed: () {
      //       print("Onpressed on scanner");
      //     },
      //     child: const Icon(
      //       Icons.qr_code_scanner_sharp,
      //       size: 50,
      //     ),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
