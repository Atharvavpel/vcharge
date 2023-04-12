import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';
import 'package:vcharge/view/homeScreen/widgets/locationFinder.dart';
import 'package:vcharge/view/homeScreen/widgets/markerHints.dart';
import 'package:vcharge/view/homeScreen/widgets/searchBar.dart';
import 'package:vcharge/view/homeScreen/widgets/virtuosoLogo.dart';

class ExistingHomeScreen extends StatelessWidget {

  String userId;
  

  ExistingHomeScreen({required this.userId ,super.key});

  //map controller is initialized here because we can pass it to another screens later
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    // print("Inside the build method of homescreen");
    return SafeArea(
      child: Stack(
        children: [
    
          // background map
          BgMap(mapController: mapController, userId: userId),
    
          // searchBar and navBar
          SearchBarContainer(userId: userId,),
    
          // location finder
          Positioned(
            bottom: 70,
            right: 0,
            child: LocationFinder(mapController: mapController,),
          ),
    
          // Virtuoso logo
          const Positioned(
            bottom: 70,
            left: 0,
            child: VirtuosoLogo(),
          ),
    
          //Hint question Mark
          const Positioned(
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
                    showBottomSheet(
                      context: context, 
                      builder: (BuildContext context){
                        return FilterPopUp(userId: userId);
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
      ),
    );
    
    
  }
}