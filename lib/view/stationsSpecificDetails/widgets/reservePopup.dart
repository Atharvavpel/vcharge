import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/services/PostMethod.dart';
import 'package:vcharge/view/stationsSpecificDetails/widgets/reservationDonePopup.dart';
import 'package:vcharge/view/walletScreen/addMoneyScreen.dart';

import '../../../models/chargerModel.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class ReservePopUp extends StatefulWidget {
  String stationId;
  String stationName;
  String stationLocation;
  ChargerModel chargerModel;
  String userId;

  ReservePopUp(
      {required this.userId,
      required this.stationId,
      required this.stationName,
      required this.stationLocation,
      required this.chargerModel,
      super.key});

  @override
  State<StatefulWidget> createState() => ReservePopUpState();
}

class ReservePopUpState extends State<ReservePopUp> {
  String? stationName;
  String? stationLocation;
  ChargerModel? chargerModel;

  var selectedDate = DateTime.now();
  DateTime selectedTimeSlot = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
  List<DateTime>? timeSlotsList;
  String? walletAmount;

  @override
  void initState() {
    stationName = widget.stationName;
    stationLocation = widget.stationLocation;
    chargerModel = widget.chargerModel;
    // Generate a list of DateTime objects representing each hour slot in the current day
    timeSlotsList = timeSlots();
    getWalletAmount();
    super.initState();
  }

  Future<void> postBooking(body) async {
    var data = await PostMethod.postRequest(
        'http://192.168.0.46:9090/vst1/booking', body);
  }

  Future<void> getWalletAmount() async {
    var data = await GetMethod.getRequest(
        'http://192.168.0.41:8081/manageUser/getWallet?userId=${widget.userId}');
    setState(() {
      walletAmount = data['walletAmount'];
    });
  }

  // This method generates a list of DateTime objects representing each hour slot in the current day
  List<DateTime> timeSlots() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day, 0, 0,
        0); // Get the start of the current day
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59,
        59); // Get the end of the current day
    final hourSlots =
        <DateTime>[]; // Initialize an empty list to store the hour slots
    // Loop through each hour in the current day and add it to the hourSlots list
    for (var i = startOfDay;
        i.isBefore(endOfDay);
        i = i.add(const Duration(hours: 1))) {
      hourSlots.add(i);
    }
    return hourSlots;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //this container contains a wrap, which consist 2 text -> stationName and chargerName
            Expanded(
              flex: 2,
              child: Container(
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    //Station Heading text
                    Container(
                      child: Text(
                        stationName!,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Station Heading text
                    Container(
                      child: Text(chargerModel!.chargerSerialNumber!),
                    ),
                  ],
                ),
              ),
            ),

            //container for station location
            Expanded(
              flex:2,
              child: Container(
                child: Row(
                  children: [
                    const Icon(Icons.location_on_rounded),
                    Text(
                      stationLocation!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),

            //Container for socket and avaliblity
            Expanded(
              flex: 2,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //container for charger socket
                  Container(
                    child: Row(
                      children: [
                        const Text(
                          'Socket: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${chargerModel!.chargerMountType}',
                        ),
                      ],
                    ),
                  ),
            
                  //container for charger availiblity
                  Container(
                    child: Row(
                      children: const [
                        Text(
                          'Availability: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Available',
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),

            //Column for date picker
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  //container for date text
                  Container(
                    width: double.maxFinite,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Choose a date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width * 0.05),
                        ),
                        Text(DateFormat('MMM dd, yyyy').format(selectedDate),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035))
                      ],
                    ),
                  ),
                  //container for date picker
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: DatePicker(
                      DateTime.now(),
                      initialSelectedDate: selectedDate,
                      selectionColor: const Color.fromARGB(255, 148, 192, 83),
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          selectedDate = date;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            //column for timeslot dropdown
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  //container for choose time text
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose your slot',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),
                  //container for time slot drop down
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: // Return a DropdownButton widget with the following properties:
                        Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.width * 0.015),
                      child: DropdownButton<DateTime>(
                          underline: Container(),
                          menuMaxHeight: MediaQuery.of(context).size.height * 0.3,
                          isExpanded: true,
                          value:
                              selectedTimeSlot, // Set the currently selected time slot as the initial value
                          onChanged: (value) {
                            // When the user selects a time slot, update the selectedTimeSlot variable and rebuild the widget
                            setState(() {
                              selectedTimeSlot = value!;
                            });
                          },
                          // Create a list of DropdownMenuItem widgets based on the timeSlots list
                          items: timeSlotsList!
                              .map(
                                (e) => DropdownMenuItem<DateTime>(
                                  value:
                                      e, // Set the value of the DropdownMenuItem to the current time slot
                                  // Display the hour value of the time slot as a Text widget
                                  child: Text(
                                    '${e.hour.toString().padLeft(2, '0')}:00', // Format the hour value as a two-digit string with leading zeros
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                  ),
                ],
              ),
            ),

            //Container for wallet balance and credit button
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Text('Wallet balance is '),
                          //rupees icon
                          Icon(
                            Icons.currency_rupee,
                            size: MediaQuery.of(context).size.width * 0.05,
                          ),
                          walletAmount == null
                              ? const CircularProgressIndicator()
                              : Text(
                                  walletAmount!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045),
                                ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddMoneyScreen(userId: widget.userId)));
                          },
                          child: const Text('Credit'))
                    ],
                  ),
                ),
              ),
            ),

            //Container for reserve button
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    postBooking(jsonEncode({
                      "bookingType": "Reservation",
                      "bookingStationId": widget.stationId,
                      "bookingDate": DateFormat("yyyy-MM-dd").format(selectedDate),
                      "bookingTime": DateFormat("HH:mm:ss").format(selectedTimeSlot),
                    }));
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ReservationDonePopUp(
                            stationName: widget.stationName,
                            chargerSerialNumber:
                                chargerModel!.chargerSerialNumber!,
                            stationLocation: widget.stationLocation,
                            bookingId: 'BKG0012324',
                            bookginStatus: 'Confirmed',
                            bookingDate: selectedDate,
                            bookingTime: selectedTimeSlot,
                          );
                        });
                  },
                  child: const Text(
                    'Reserve',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
