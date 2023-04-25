import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';
import 'package:vcharge/view/homeScreen/widgets/locationFinder.dart';
import 'package:vcharge/view/homeScreen/widgets/markerHints.dart';
import 'package:vcharge/view/homeScreen/widgets/searchBar/searchBar.dart';
import 'package:vcharge/view/homeScreen/widgets/sideBarDrawer.dart';
import 'package:vcharge/view/homeScreen/widgets/virtuosoLogo.dart';


class ExistingHomeScreen extends StatefulWidget {
  String userId;

  ExistingHomeScreen({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => ExistingHomeScreenState();
}

class ExistingHomeScreenState extends State<ExistingHomeScreen> {
  //SetState call back function
  updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print("Inside the build method of homescreen");
    return SafeArea(
      child: Scaffold(
        drawer: SideBarDrawer(userId: widget.userId),
        body: Stack(
          children: [
            // background map
            BgMap(userId: widget.userId),

            // searchBar and navBar
            SearchBarContainer(
              userId: widget.userId,
              callBack: updateState,
            ),

            // location finder
            Positioned(
              bottom: 0,
              right: 0,
              child: LocationFinder(updateState: updateState),
            ),

            // Virtuoso logo
            const Positioned(
              bottom: 0,
              left: 0,
              child: VirtuosoLogo(),
            ),

            //Hint question Mark
            Positioned(
              bottom: Get.height * 0.07,
              right: 0,
              child: const MarkerHints(),
            ),

            // filter
            Positioned(
              bottom: Get.height * 0.14,
              right: 0,
              child: Container(
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 1)
                ], borderRadius: BorderRadius.circular(30)),
                margin: const EdgeInsets.only(right: 13, bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: GestureDetector(
                    onTap: () {
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return FilterPopUp(userId: widget.userId);
                          });
                    },
                    child: const Icon(
                      Icons.filter_alt_sharp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
