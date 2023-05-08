import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vcharge/services/GetMethod.dart';

import '../../../models/bookingModel.dart';
import 'cancelReservAlertPopUp.dart';

class UpcomingBookingDetailsPopUp extends StatefulWidget {
  BookingModel bookingModel;
  String? stationName;
  String? stationAddress;

  UpcomingBookingDetailsPopUp(
      {required this.bookingModel,
      required this.stationName,
      required this.stationAddress,
      super.key});

  @override
  State<UpcomingBookingDetailsPopUp> createState() =>
      UpcomingBookingDetailsPopUpState();
}

class UpcomingBookingDetailsPopUpState
    extends State<UpcomingBookingDetailsPopUp> {
  BookingModel? bookingModel;

  @override
  void initState() {
    // TODO: implement initState
    bookingModel = widget.bookingModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.55,
      child: Column(children: [
        //"Booking Details" Heading text
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 113, 174, 76),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Center(
                child: Text(
              'Booking Details',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Get.height * 0.025),
            )),
          ),
        ),

        //ListTile for station name, address and direction icon
        Expanded(
          flex: 6,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
            child: ListTile(
              title: Text(
                widget.stationName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: Get.width * 0.05),
              ),
              subtitle: Text(
                widget.stationAddress!,
                maxLines: 3,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.directions),
                onPressed: () {},
              ),
            ),
          ),
        ),

        //Row for booking ID and booking Status
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Column for booking Id
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Booking Id',
                      style: TextStyle(
                          fontSize: Get.width * 0.04, color: Colors.grey),
                    ),
                    Text(
                      bookingModel!.bookingId!,
                      style: TextStyle(
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),

              //Column for booking Status
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Booking Status',
                      style: TextStyle(
                          fontSize: Get.width * 0.04, color: Colors.grey),
                    ),
                    Text(
                      bookingModel!.bookingStatus!,
                      style: TextStyle(
                          fontSize: Get.width * 0.035,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        //Row for booking date and booking Time
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Column for booking date
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Booking Date',
                      style: TextStyle(
                          fontSize: Get.width * 0.04, color: Colors.grey),
                    ),
                    Text(
                      DateFormat("dd MMM, yyyy")
                          .format(DateTime.parse(bookingModel!.bookingDate!)),
                      style: TextStyle(
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),

              //Column for booking time
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Booking Time',
                      style: TextStyle(
                          fontSize: Get.width * 0.04, color: Colors.grey),
                    ),
                    Text(
                      bookingModel!.bookingTime!,
                      style: TextStyle(
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        //Row for Socket type and booking amount
        Expanded(
          flex: 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Column for socket type
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Socket Type',
                      style: TextStyle(
                          fontSize: Get.width * 0.04, color: Colors.grey),
                    ),
                    Text(
                      bookingModel!.bookingSocket!,
                      style: TextStyle(
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),

              //Column for booking amount
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Booking Amount',
                      style: TextStyle(
                          fontSize: Get.width * 0.04, color: Colors.grey),
                    ),
                    Text(
                      'Rs. ${bookingModel!.bookingAmount!}',
                      style: TextStyle(
                          fontSize: Get.width * 0.035,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //button for start charging
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(Get.width * 0.035),
                      child: const Text(
                        'Start Charging',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                //button for cancel booking
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CancleReservAlertPopUp();
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.green),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.all(Get.width * 0.03),
                      child: const Text(
                        'Cancel Booking',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
