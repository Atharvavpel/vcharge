import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/existingHomeScreen.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';

import 'package:vcharge/view/homeScreen/widgets/sideBarDrawer.dart';
import 'package:vcharge/view/listOfStations/listOfStations.dart';
import 'package:vcharge/view/qrScanner.dart/scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
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

    
// variables for index in bottom bar
  int selectedIndex = 0;

  

  @override
  Widget build(BuildContext context) {
    

// screens
    List<dynamic> screens = [
      const ExistingHomeScreen(),
      ListOfStations(),
      QRScannerWidget(),
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
      const FilterPopUp(),
          
    ];

// bottom bar icons
    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.list, size: 30),
  //     IconButton(
  //       onPressed: () async {
  //   String barcodeResult = await ScannerQr().scanBarcode(); 
  //   print(barcodeResult);
  //    // Do something with the barcode result, such as navigate to a new screen
  // },
  //       icon: const Icon(Icons.qr_code_scanner, size: 30)),
        const Icon(Icons.qr_code_scanner, size: 30),
      const Icon(Icons.filter_alt_sharp, size: 30)
    ];
    

    return Scaffold(

// this variable is used to extend the background to the appbar
      extendBodyBehindAppBar: true,

// this variable is used to extend the background to the bottombar
      extendBody: true,

// this is drawer function
      drawer: const SideBarDrawer(),

// this is body 
      body: screens[selectedIndex],
        
// this is bottom bar        
      bottomNavigationBar: CurvedNavigationBar(
          height: MediaQuery.of(context).size.height * 0.07,
          animationCurve: Curves.easeInOut,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white,
          animationDuration: const Duration(milliseconds: 300),
          items: items,
          index: selectedIndex,
          onTap: (index) {
            setState(() {
            selectedIndex = index;
            });
          }
        
        ),
    );
  }
}
