import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcharge/view/walletScreen/walletScreen.dart';
import 'package:vcharge/view/myVehicleScreen/myVehicleScreen.dart';

class HorizontalSideBar extends StatefulWidget {

  String userId;

  HorizontalSideBar({required this.userId, super.key});

  @override
  State<HorizontalSideBar> createState() => HorizontalSideBarState();
}

class HorizontalSideBarState extends State<HorizontalSideBar> {

// boolean variables used for adding the texture effect to the respective buttons
  bool isVehicle = false;
  bool isMapRoute = false;
  bool isWallet = false;
  bool isFavourite = false;
  bool isReservation = false;
  bool isMore = false;

// boolean variable for more side panel 
  bool isMoreSidePaneOpen = false;

  


  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [


// container - vehicle addition
            GestureDetector(
              key: const Key('myVehicleButton'),
              onTap: () {
                setState(() {
                  isVehicle = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    isVehicle = false;
                  });
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyVehicleScreen(userId: widget.userId,)));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: isVehicle
                      ? const Color.fromARGB(255, 115, 204, 43)
                      : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      FaIcon(FontAwesomeIcons.car,size: 20,color: Color.fromARGB(255, 51, 50, 50),),
                      SizedBox(width: 10),
                      Text(
                        'My vechicle',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),


// container - Route
            GestureDetector(
              key: const Key('routeButton'),
              onTap: () {
                setState(() {
                  isMapRoute = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    isMapRoute = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  // border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: isMapRoute ? const Color.fromARGB(255, 142, 181, 239) : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      FaIcon(FontAwesomeIcons.route,size: 20,color: Color.fromARGB(255, 51, 50, 50),),
                      SizedBox(width: 10),
                      Text(
                        'Route',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),


 // container - my wallet            
            GestureDetector(
              key: const Key('myWalletButton'),
              onTap: () {
                setState(() {
                  isWallet = true;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletScreen(userId: widget.userId,)));
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    isWallet = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  // border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: isWallet ? const Color.fromARGB(255, 142, 181, 239) : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.wallet, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'My Wallet',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),


// container - favourites
            GestureDetector(
              key: const Key('favouriteButton'),
              onTap: () {
                setState(() {
                  isFavourite = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    isFavourite = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  // border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: isFavourite ? const Color.fromARGB(255, 142, 181, 239) : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'Favourite',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),


// container - reservations
            GestureDetector(
              key: const Key('reservationButton'),
              onTap: () {
                setState(() {
                  isReservation = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    isReservation = false;
                  });
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    // border: Border.all(),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(2, 2),
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: isReservation ? const Color.fromARGB(255, 142, 181, 239) : Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.book_online, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'Reservations',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),


// container - more optionsPage
            GestureDetector(
              key: const Key('moreOptionButton'),
              onTap: () {
                setState(() {
                  isMore = true;
                });
  
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    isMore = false;
                  });
                });
              },

              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  // border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: isMore ? const Color.fromARGB(255, 142, 181, 239) : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.more_horiz_sharp, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'More',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),




                    ],
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

