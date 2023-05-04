import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vcharge/models/bookingModel.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/reservationsScreen/widgets/upcomingBookingDetailsPopUp.dart';

class ReservationScreen extends StatefulWidget {
  String userId;

  ReservationScreen({required this.userId, super.key});
  @override
  State<StatefulWidget> createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen> {
  bool upcomingButton = true;
  bool historyButton = false;

  String? stationName;
  String? stationAddress;

  List<BookingModel> upcomingBookingList = [];
  List<BookingModel> bookingHistoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getbookingDetails();
    getStationNameAndAddress();
  }

  Future<void> getStationNameAndAddress() async {
    var data = await GetMethod.getRequest(
        'http://192.168.0.43:8080/manageStation/getStation?stationId=STN20230502102753410');
    stationName = data['stationName'];
    stationAddress =
        '${data['stationAddressLineOne']}, ${data['stationAddressLineTwo']}, ${data['stationCity']}';
  }

  Future<void> getbookingDetails() async {
    var data = await GetMethod.getRequest(
        'http://192.168.0.46:4040/managebooking/bookingscustomer?bookingCustomerId=${widget.userId}');
    if (data != null && data.isNotEmpty) {
      setState(() {
        for (int i = 0; i < data.length; i++) {
          BookingModel booking = BookingModel.fromJson(data[i]);
          var bookingDateTime =
              DateTime.parse('${booking.bookingDate} ${booking.bookingTime}');
          if (bookingDateTime.isAfter(DateTime.now())) {
            upcomingBookingList.add(booking);
          } else {
            bookingHistoryList.add(booking);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //appBar
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Reservations'),
          ),
          body: Column(
            children: [
              //Row for Upcoming and History button
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Elevated Button for Upcomming
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: upcomingButton
                                  ? const Color.fromARGB(255, 123, 201, 67)
                                  : Colors.white),
                          onPressed: () {
                            setState(() {
                              upcomingButton = true;
                              historyButton = false;
                            });
                          },
                          child: Text(
                            'Upcoming',
                            style: TextStyle(
                                color: upcomingButton
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold),
                          )),

                      //Elevated Button for History
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: historyButton
                                  ? const Color.fromARGB(255, 123, 201, 67)
                                  : Colors.white),
                          onPressed: () {
                            setState(() {
                              upcomingButton = false;
                              historyButton = true;
                            });
                          },
                          child: Text('History',
                              style: TextStyle(
                                  color: historyButton
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold))),
                    ],
                  )),

              //Expanded for to show the list of reservations
              Expanded(
                flex: 15,
                child: upcomingButton == true
                    ? //List for upcomming
                    upcomingBookingList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: upcomingBookingList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                      ),
                                      builder: (context) {
                                        return UpcomingBookingDetailsPopUp(
                                          bookingModel:
                                              upcomingBookingList[index],
                                          stationAddress: stationAddress,
                                          stationName: stationName,
                                        );
                                      });
                                },
                                child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Color.fromARGB(255, 235, 255, 254),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.02,
                                        vertical: Get.height * 0.01),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // //Station Name
                                          Text(
                                            stationName!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Get.width * 0.05),
                                          ),

                                          //Row for booking ID, socket Type, and booking Status
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Get.height * 0.005),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                //Column Booking ID
                                                Expanded(
                                                  child: Container(
                                                    height: Get.height * 0.07,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Booking Id',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Card(
                                                            elevation: 0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    203,
                                                                    255,
                                                                    204),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.004,
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.015),
                                                              child: Text(
                                                                upcomingBookingList[
                                                                        index]
                                                                    .bookingId!,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                //Column Socket Type
                                                Expanded(
                                                  child: Container(
                                                    height: Get.height * 0.07,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Socket Type',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Card(
                                                            elevation: 0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    203,
                                                                    255,
                                                                    204),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.004,
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.015),
                                                              child: Text(
                                                                upcomingBookingList[
                                                                        index]
                                                                    .bookingSocket!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                //Column booking status
                                                Expanded(
                                                  child: Container(
                                                    height: Get.height * 0.07,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Booking Status',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Card(
                                                            elevation: 0,
                                                            color: Colors.white,
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.004,
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.015),
                                                              child: Text(
                                                                upcomingBookingList[
                                                                        index]
                                                                    .bookingStatus!
                                                                    .toUpperCase(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03,
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          //Wrap for date and time
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Get.height * 0.004),
                                            child: Wrap(
                                              spacing: 20,
                                              children: [
                                                Text(DateFormat("dd MMM, yyyy")
                                                    .format(DateTime.parse(
                                                        upcomingBookingList[
                                                                index]
                                                            .bookingDate!))),
                                                Text(upcomingBookingList[index]
                                                    .bookingTime!),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            })
                    : //List for history
                    bookingHistoryList.isEmpty
                        ? const CircularProgressIndicator()
                        : ListView.builder(
                            itemCount: bookingHistoryList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {},
                                child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Color.fromARGB(255, 235, 255, 254),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.02,
                                        vertical: Get.height * 0.01),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //Station Name
                                          // Text(
                                          //   bookingHistoryList[index]
                                          //       .bookingStationName!,
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: Get.width * 0.05),
                                          // ),

                                          //Row for booking ID, socket Type, and booking Status
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Get.height * 0.005),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                //Column Booking ID
                                                Expanded(
                                                  child: Container(
                                                    height: Get.height * 0.07,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Booking Id',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Card(
                                                            elevation: 0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    203,
                                                                    255,
                                                                    204),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.004,
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.015),
                                                              child: Text(
                                                                bookingHistoryList[
                                                                        index]
                                                                    .bookingId!,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                //Column Socket Type
                                                Expanded(
                                                  child: Container(
                                                    height: Get.height * 0.07,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Socket Type',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Card(
                                                            elevation: 0,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    203,
                                                                    255,
                                                                    204),
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.004,
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.015),
                                                              child: Text(
                                                                bookingHistoryList[
                                                                        index]
                                                                    .bookingSocket!,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),

                                                //Column booking status
                                                Expanded(
                                                  child: Container(
                                                    height: Get.height * 0.07,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          'Booking Status',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Get.width *
                                                                      0.035,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Card(
                                                            elevation: 0,
                                                            color: Colors.white,
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.004,
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.015),
                                                              child: Text(
                                                                bookingHistoryList[
                                                                        index]
                                                                    .bookingStatus!
                                                                    .toUpperCase(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        Get.width *
                                                                            0.03,
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          //Wrap for date and time
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Get.height * 0.004),
                                            child: Wrap(
                                              spacing: 20,
                                              children: [
                                                Text(DateFormat("dd MMM, yyyy")
                                                    .format(DateTime.parse(
                                                        bookingHistoryList[
                                                                index]
                                                            .bookingDate!))),
                                                Text(bookingHistoryList[index]
                                                    .bookingTime!),
                                              ],
                                            ),
                                          ),

                                          //Wrap for amount paid
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Get.height * 0.004),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //Row for amount paid
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Amount Paid',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Card(
                                                        elevation: 0,
                                                        color: Color.fromARGB(
                                                            255, 203, 255, 204),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      Get.height *
                                                                          0.004,
                                                                  horizontal:
                                                                      Get.width *
                                                                          0.015),
                                                          child: Text(
                                                            'Rs. 300',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )),
                                                  ],
                                                ),

                                                Text(
                                                  'Consumed 1.5 kWh',
                                                  style: TextStyle(
                                                      fontSize:
                                                          Get.width * 0.04,
                                                      color: Colors.green),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            }),
              )
            ],
          )),
    );
  }
}