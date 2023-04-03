import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';
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
        BgMap(),

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

        // filter
        Positioned(
          bottom: 190,
          right: 0,
          child: Container(
            decoration: BoxDecoration(boxShadow: const [
        BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 1)
      ], borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.only(right: 13, bottom: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: GestureDetector(
                onTap: (){
                  showDialog(
                    context: context, 
                    builder: (BuildContext context){
                      return FilterPopUp();
                    }
                  );
                },
                child: const Icon(Icons.filter_alt_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
    
    
  }
}


