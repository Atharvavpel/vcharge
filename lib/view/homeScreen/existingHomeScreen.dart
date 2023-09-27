import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcharge/view/favouriteScreen/favouriteScreen.dart';
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

  // @override
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

            Positioned(
              bottom: Get.height * 0.15,
              right: 0,
              child: Semantics(
                label: "favriteButton",
                child: GestureDetector(
                  key: const Key('favriteButton'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FavouriteSceen(userId: widget.userId),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: const EdgeInsets.only(right: 13),
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // filter
            Positioned(
              bottom: Get.height * 0.21,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      builder: (BuildContext context) {
                        return FilterPopUp(userId: widget.userId);
                      });
                },
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  margin: const EdgeInsets.only(right: 13, bottom: 10),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.filter_alt_sharp,
                      color: Colors.white,
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
