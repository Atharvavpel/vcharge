import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/bookingModel.dart';

class BookingHistoryDetailsPopUp extends StatefulWidget {
  String stationName;
  BookingModel bookingModel;

  BookingHistoryDetailsPopUp({required this.bookingModel, required this.stationName,super.key});

  @override
  State<StatefulWidget> createState() => BookingHistoryDetailsPopUpState();
}

class BookingHistoryDetailsPopUpState
    extends State<BookingHistoryDetailsPopUp> {
  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: Get.height * 0.5,
        child: Column(
          children: [
            //Container for heading Text
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 113, 174, 76),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(Get.height * 0.008),
                    child: Text(
                      'Booking Details',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Get.height * 0.025),
                    ),
                  )),
                ),
                //Cross button
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: FaIcon(
                        FontAwesomeIcons.x,
                        color: Colors.white,
                        size: Get.width * 0.045,
                      )),
                ),
              ],
            ),
      
            //Row for Booking Id
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      child: Text(
                    'Booking Id',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                    widget.bookingModel.bookingId!,
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
      
            //Row for Booking Date and Time
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      child: Text(
                    'Booking Date and Time',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat("dd MMM, yyyy").format(DateTime.parse(widget.bookingModel.bookingDate!)),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget.bookingModel.bookingTime!,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ))
                ],
              ),
            ),
          
            //Row for Booked for
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                children: const [
                  Expanded(
                      child: Text(
                    'Booking for',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                    '1hr 30min',
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
      
            //Row for Charged for
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                children: const [
                  Expanded(
                      child: Text(
                    'Charged For',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                     '1hr',
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
      
            //Row for Charger
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      child: Text(
                    'Charger',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                     widget.stationName,
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
      
            //Row for Socket Type
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                      child: Text(
                    'Socket Type',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                     widget.bookingModel.bookingSocket!,
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
      
            //Row for Energy Consumed
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                      child: Text(
                    'Energy Consumed',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
                  Expanded(
                      child: Text(
                     '13 kWh',
                    textAlign: TextAlign.left,
                  ))
                ],
              ),
            ),
      
            //Payment made using wallet card
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.height * 0.01),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Expanded(flex: 2,child: Icon(Icons.wallet, color: Colors.green,)),
                      Expanded(flex: 11,child: Text('Payment Made Using Wallet', style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
