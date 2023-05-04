import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'cancelReservationPopUp.dart';

class CancleReservAlertPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        children: [
          //title text
          const Text(
            'Cancel Reservation',
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          ),
          //cross button
          Positioned(
            top: 4,
            right: 0,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: FaIcon(FontAwesomeIcons.x, size: Get.width * 0.05, color: Colors.green,))
          )
        ],
      ),
      content: const Text('Are You Sure You Want To Cancel The Booking?'),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
            showModalBottomSheet(
              context: context, 
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
              ),
              builder: (context){
              return CancelReservtionPopUp();
            });
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.green),
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: EdgeInsets.all(Get.width * 0.02),
              child: const Text(
                'Proceed',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
