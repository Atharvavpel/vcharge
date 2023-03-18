
import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';

import 'package:vcharge/view/homeScreen/widgets/bottomBar.dart';
import 'package:vcharge/view/homeScreen/widgets/locationFinder.dart';
import 'package:vcharge/view/homeScreen/widgets/logo.dart';
import 'package:vcharge/view/homeScreen/widgets/searchBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  @override
  void initState() {
    super.initState();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Stack(children: [
        
        // background map
        BgMap(),

        // searchBar and navBar
        SearchBarContainer(),

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
