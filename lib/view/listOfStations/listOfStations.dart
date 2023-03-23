import 'package:flutter/material.dart';
import 'package:vcharge/models/stationModel.dart';
import 'package:vcharge/services/getMethod.dart';


class ListOfStations extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ListOfStationsState();
}

class ListOfStationsState extends State<ListOfStations> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStationList();
  }

  List<dynamic> stationsList = [];

  Future<void> getStationList() async {
    print("Fetching Data");
    var data =
        await GetMethod.getRequest('http://192.168.0.113:8081/vst1/stations');
    if (data != null) {
      setState(() {
        stationsList = data;
      });
    }
    print("Data fetched");
  }



  //this function takes a parameter string as availiblityStatus, and returns a color based on availablity
  MaterialColor getAvailablityColor(String availiblityStatus) {
    if (availiblityStatus == 'Available') {
      return Colors.green;
    } else if (availiblityStatus == 'NotAvailable') {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Inside the build method of listofobject");
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Stations'),
      ),
      body: Container(
        color: Color.fromARGB(255, 215, 226, 215),
        child: ListView.builder(
            itemCount: stationsList.length,
            itemBuilder: (context, index) {
              return ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: getAvailablityColor("Available"),
                  radius: 6,
                ),
                title: Text(
                  stationsList[index]['stationName'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
                subtitle: Text('${stationsList[index]['stationLocation']}'),
                children: [


                  //container for contact number
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(7)),
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 13, left: 13),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, bottom: 3, top: 3),
                        child: Row(children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 2, bottom: 2, left: 2, right: 15),
                            child: Icon(Icons.call),
                          ),
                          Text(
                              "${stationsList[index]['stationContactNumber']}"),
                        ]),
                      )),



                  //Container for active time and parking type
                  Container(
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 13, left: 13),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [


                        //Container for charger type
                        Container(
                          width: 110,
                          height: 80,
                          margin: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 4, right: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Active Time'),
                                const Divider(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Text(stationsList[index]['stationWorkingTime'])
                              ],
                            ),
                          ),
                        ),



                        //container for availiblity type
                        Container(
                          width: 110,
                          height: 80,
                          margin: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 4, right: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Parking Type'),
                                const Divider(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  thickness: 2,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                Text(stationsList[index]['stationParkingType'])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),



                  //Container for amenities
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 13, left: 13),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Amenities:',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Wrap(
                          spacing: 2.0, // set the spacing between the children
                          // runSpacing:
                          //     2.0, // set the spacing between the lines
                          children: List.generate(
                              stationsList[index]['stationAmenity'] != null
                                  ? stationsList[index]['stationAmenity'].length
                                  : 0, (item) {
                            return Chip(
                              label: Text(
                                '${stationsList[index]['stationAmenity'][item]}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}