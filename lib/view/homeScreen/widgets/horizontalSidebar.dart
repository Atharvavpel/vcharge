import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcharge/view/myVehicleScreen/myVehicleScreen.dart';

class HorizontalSideBar extends StatefulWidget {
  const HorizontalSideBar({super.key});

  @override
  State<HorizontalSideBar> createState() => HorizontalSideBarState();
}

class HorizontalSideBarState extends State<HorizontalSideBar> {


  bool isVehicle = false;
  bool isMapRoute = false;
  bool isWallet = false;
  bool isFavourite = false;
  bool isReservation = false;
  bool isMore = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isVehicle = true;
                });
                Future.delayed(const Duration(seconds: 1)).then((_) {
                  setState(() {
                    isVehicle = false;
                  });
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=> MyVehicleScreen()));
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
                      ? Color.fromARGB(255, 115, 204, 43)
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
            GestureDetector(
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
                    children: [
                      Icon(Icons.map, color: Colors.grey[700]),
                      const SizedBox(width: 10),
                      const Text(
                        'Route',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isWallet = true;
                });
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
            GestureDetector(
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
                  borderRadius: BorderRadius.all(Radius.circular(20)),
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
            GestureDetector(
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
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
            GestureDetector(
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
                  borderRadius: BorderRadius.all(Radius.circular(20)),
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