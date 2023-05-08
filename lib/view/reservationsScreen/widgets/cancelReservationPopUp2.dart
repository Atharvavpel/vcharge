import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/bookingModel.dart';

class CancelReservtionPopUp extends StatefulWidget {
  CancelReservtionPopUp({super.key});

  @override
  State<CancelReservtionPopUp> createState() => CancelReservtionPopUpState();
}

class CancelReservtionPopUpState extends State<CancelReservtionPopUp> {
  BookingModel? bookingModel;

  TextEditingController additionInfo = TextEditingController();

  var cancelReasonsList = [
    'Time Issue',
    'Change of Plans',
    'Technical Issue',
    'Other'
  ];

  var selectedReason;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //"Booking Details" Heading text
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 113, 174, 76),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cancel Reservation',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.025),
              ),
            )),
          ),
      ],
    );
  }
  
}