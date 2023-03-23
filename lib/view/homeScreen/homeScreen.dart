import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/existingStack.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';

import 'package:vcharge/view/homeScreen/widgets/sideBarDrawer.dart';
import 'package:vcharge/view/listOfStations/listOfStations.dart';
import 'package:vcharge/view/qrScanner.dart/scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
/*

// variable for keeping track of the index for bottom bar
  int selectedIndex = 0;

// variable for filter button being pressed
  bool isFilterOpen = false;
  int filterIndex = 3;

// variable for list button being pressed
  bool isListOpen = false;
  int selectedIndexListButton = 0;

  @override
  void initState() {
    super.initState();
  }



  List<Widget> _pages = [
    ExistingStack(),
    ListOfStations(),
    ScannerQr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// this variable is used to extend the background to the appbar
      extendBodyBehindAppBar: true,

// this is drawer function
      drawer: const SideBarDrawer(),

      body: IndexedStack(
        index: selectedIndex,
        children: [
          ..._pages,
        ],
      ),

/*
// used stack to display the widgets one above the other
      body: Stack(children: [
        // background map
        BgMap(),

        // searchBar and navBar
        const SearchBarContainer(),

        // location finder
        const Positioned(
          bottom: 10,
          right: 0,
          child: LocationFinder(),
        ),

        // Virtuoso logo
        const Positioned(
          bottom: 10,
          left: 0,
          child: VirtuosoLogo(),
        ),

        //Hint question Mark
        Positioned(
          bottom: 70,
          right: 0,
          child: MarkerHints(),
        ),
      ]),


*/
      // bottom app bar

// bottomNavigationBar: Theme(
//         data: Theme.of(context).copyWith(
//           iconTheme: const IconThemeData(color: Colors.white)
//         ),



      bottomNavigationBar: CurvedNavigationBar(
        height: MediaQuery.of(context).size.height * 0.07,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color.fromARGB(255, 165, 220, 167),
        animationDuration: const Duration(milliseconds: 300),
        index: selectedIndex,
      
        items: <Widget>[
          // button for home page
          const Icon(Icons.home, size: 30),
      
          const Icon(Icons.list, size: 30),
      
          // button for qr code scanner
          const Icon(Icons.qr_code_scanner, size: 30),
      
          // button for filter
          Stack(
            children: [
            InkWell(
              splashColor: Colors.red,
              onTap: () {
                setState(() {
                  isFilterOpen = true;
                  selectedIndex = 3;
                });
      
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterPopUp(
                        onClose: () {
                      setState(() {
                        isFilterOpen = false;
                        selectedIndex = 0;
                      });
                        }
                      );
                    }
                );
                
              },
              child: const Icon(Icons.filter_alt_sharp, size: 30),
            ),
            if (isFilterOpen)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isListOpen = false;
                        selectedIndex = 0;
                      });
                    },
                  ),
                ),
              ),
            ]
          ),
        ],
        
        
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            
          });
        },
      
        
      )

/*
      // bottom app bar
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey,s
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
          InkWell(
            onTap: () {
                
                
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterPopUp(
                        onClose: () {
                      setState(() {
                        _isFilterOpen = false;
                      });
                        }
                      );
                    }
                );
              },
            child: const Icon(Icons.filter_alt_sharp, size: 30)
          ),
        ],
      ),

      */



      // FilterPopUp(onClose: () {
      //         selectedIndex = 0;
      //         isFilterOpen = false;
      //       setState(() {
      //         print("inside the setstate function of the filterpopup");
      //       });
      //     }), 

      
    );
  }


*/

// variable for index in bottom bar
  int selectedIndex = 0;
  bool isFilterOpen = false;

  @override
  Widget build(BuildContext context) {
    

// screens
    var screens = [
      ExistingStack(),
      ListOfStations(),
      ScannerQr(),
      FilterPopUp(),
          
    ];

// bottom bar icons
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.list, size: 30),
      const Icon(Icons.qr_code_scanner, size: 30),
      const Icon(Icons.filter_alt_sharp, size: 30)
    ];
    

    return Scaffold(
// this variable is used to extend the background to the appbar
      extendBodyBehindAppBar: true,

      extendBody: true,

// this is drawer function
      drawer: const SideBarDrawer(),
      body: screens[selectedIndex],
        
      bottomNavigationBar: CurvedNavigationBar(
          height: MediaQuery.of(context).size.height * 0.07,
          animationCurve: Curves.easeInOut,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: const Color.fromARGB(255, 165, 220, 167),
          animationDuration: const Duration(milliseconds: 300),
          items: items,
          index: selectedIndex,
          onTap: (index) {
            setState(() {
            selectedIndex = index;
            });
          }
        //   onTap: (index) {
        //     print("index is: $index");
        //     if (index == 3) {
        //   isFilterOpen = true;
        // } else {
        //   isFilterOpen = false;         
        // }
        //     selectedIndex = index;

        //     print("Selected index is: $selectedIndex");
        //     setState(() {
        //       // isFilterOpen = false;
        //     });
        //   }
        ),
    );
  }
}
