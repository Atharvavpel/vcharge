import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/existingHomeScreen.dart';

import 'package:vcharge/view/homeScreen/widgets/sideBarDrawer.dart';
import 'package:vcharge/view/listOfStations/listOfStations.dart';
import 'package:vcharge/view/qrScanner.dart/scanner.dart';

class HomeScreen extends StatefulWidget {
  final Login login;
  const HomeScreen({Key? key, required this.login}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class Login {
  final String username;
  final String password;

  Login(this.username, this.password);
}

class HomeScreenState extends State<HomeScreen> {
/*

keep this code for future reference:


this is screen with onclose function
      FilterPopUp(onClose: () {
              selectedIndex = 0;
              isFilterOpen = false;
            setState(() {
              print("inside the setstate function of the filterpopup");
            });
          }), 


 this is ontap of curvednavigation bar
        onTap: (index) {
            print("index is: $index");
            if (index == 3) {
          isFilterOpen = true;
        } else {
          isFilterOpen = false;         
        }
            selectedIndex = index;

            print("Selected index is: $selectedIndex");
            setState(() {
              // isFilterOpen = false;
            });
          }


    */

  //this the user ID of the current user who is logged in
  static String userId = "USR20230517060841379";

// variables for index in bottom bar
  int selectedIndex = 1;

  final GlobalKey<CurvedNavigationBarState> bottomNavBarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
// screens
    List<dynamic> screens = [
      Semantics(
          label: "listOfStationPage",
          value: 'listOfStationPage',
          child: ListOfStations(
            userId: userId,
          )),
      Semantics(
        label: "homePage",
        value: "homePage",
        child: ExistingHomeScreen(
          userId: userId,
        ),
      ),
      Semantics(
          label: "scannerPage",
          value: "scannerPage",
          child: QRScannerWidget(
            userId: userId,
          )),
      // ScannerQr.qrScanner(),
      //     FutureBuilder<dynamic>(
      //   future: ScannerQr.qrScanner(),
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.hasError) {
      //       return Text('Error: ${snapshot.error}');
      //     } else {
      //       // Use the result of the Future to build the widget
      //       return Text('QR code scanned: ${snapshot.data}');
      //     }
      //   },
      // ),
    ];

// bottom bar icons
    final items = <Widget>[
      Icon(Icons.list,
          size: 30, color: selectedIndex == 0 ? Colors.white : Colors.white),
      Icon(Icons.home,
          size: 30, color: selectedIndex == 1 ? Colors.white : Colors.white),
      Icon(Icons.qr_code_scanner,
          size: 30, color: selectedIndex == 2 ? Colors.white : Colors.white),
    ];

    // return Scaffold(

    // // this variable is used to extend the background to the appbar
    //   extendBodyBehindAppBar: true,

    // // this variable is used to extend the background to the bottombar
    //   extendBody: true,

    // // this is drawer function
    //   drawer: SideBarDrawer(userId: userId),

    // // this is body
    //   body: screens[selectedIndex],

    // // this is bottom bar
    //   bottomNavigationBar: CurvedNavigationBar(
    //       height: MediaQuery.of(context).size.height * 0.07,
    //       animationCurve: Curves.easeInOut,
    //       backgroundColor: Colors.transparent,
    //       buttonBackgroundColor: Colors.white,
    //       animationDuration: const Duration(milliseconds: 300),
    //       items: items,
    //       index: selectedIndex,
    //       onTap: (index) {
    //         setState(() {
    //           selectedIndex = index;
    //         });
    //       }),

    // );

    return WillPopScope(
        onWillPop: () async {
          if (selectedIndex != 1) {
            // if not on home screen, navigate to home screen and return false
            setState(() {
              selectedIndex = 1;
            });
            return false;
          } else {
            // if on home screen, allow back button press to close the app
            return true;
          }
        },
        child: Scaffold(
          // this variable is used to extend the background to the appbar
          extendBodyBehindAppBar: true,

          // this variable is used to extend the background to the bottombar
          extendBody: true,
          drawer: SideBarDrawer(userId: userId),
          // this is body
          body: screens[selectedIndex],

          // this is bottom bar
          bottomNavigationBar: CurvedNavigationBar(
              color: Colors.green,
              key: bottomNavBarKey,
              height: MediaQuery.of(context).size.height * 0.07,
              animationCurve: Curves.easeInOut,
              backgroundColor: Colors.transparent,
              buttonBackgroundColor: Colors.green,
              animationDuration: const Duration(milliseconds: 300),
              items: items,
              index: selectedIndex,
              onTap: (index) {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
                setState(() {
                  selectedIndex = index;
                });
              }),
        ));
  }
}
