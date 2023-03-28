import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';
import 'package:vcharge/view/homeScreen/widgets/locationFinder.dart';
import 'package:vcharge/view/homeScreen/widgets/markerHints.dart';
import 'package:vcharge/view/homeScreen/widgets/searchBar.dart';
import 'package:vcharge/view/homeScreen/widgets/virtuosoLogo.dart';

class ExistingHomeScreen extends StatelessWidget {

  const ExistingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // print("Inside the build method of homescreen");
    return Stack(
      children: [

        // background map
        const BgMap(),

        // searchBar and navBar
        SearchBarContainer(),

        // location finder
        const Positioned(
          bottom: 70,
          right: 0,
          child: LocationFinder(),
        ),

        // Virtuoso logo
        const Positioned(
          bottom: 70,
          left: 0,
          child: VirtuosoLogo(),
        ),

        //Hint question Mark
        Positioned(
          bottom: 130,
          right: 0,
          child: MarkerHints(),
        ),
      ],
    );
    
    
  }
}




/*

List<Widget> _pages = [
  HomeScreen(),
  ListOfStations(),
  ExistingStack(),
];

*/