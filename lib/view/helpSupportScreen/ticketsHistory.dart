/*


{

   "supportCustomerId":"USR20230410143239876",

    "supportHostId":"HST20230410143238848",

    "supportStationId":"STN20230412173245778",

    "supportVendorId":"VED20230412173245778",

    "supportSubject":"charged the wrong amount",

    "supportDescription":"On 30th I was charged with the wrong amount",

    "supportStatus":"pending",

    "supportAssignedTo":"snehal",

    "supportPriority":"high",

    "supportCategory":"financial",

    "subSupportCategory":"booking",

    "supportSideResponse":[

        "Thank you for bringing this to our attention. Our technical team will investigate the issue and get back to you as soon as possible."

    ],

    "customerSideResponse":[

        "Thank you for your prompt response. I appreciate your efforts to resolve the issue."

    ],

    "supportImageLink":"data:image/jpg;base64,/9j/",

    "createdBy":"Admin"

}


*/


import 'package:flutter/material.dart';
import 'package:vcharge/models/supportModel.dart';
import 'package:vcharge/services/GetMethod.dart';

class TicketHistoryScreen extends StatefulWidget {
  String userId;

  TicketHistoryScreen({super.key, required this.userId});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {

  String supportUrl = "http://192.168.0.243:8091/manageSupport/getSupports";

  //this list store the list of stations
  List<dynamic> raiseTicketList = [];

  @override
  void initState() {
    // TODO: implement initState
    getAllSupport();
    super.initState();
  }

  Future<void> getAllSupport() async {

    try {
      var data = await GetMethod.getRequest(supportUrl);
      if (data.isNotEmpty) {
        raiseTicketList.clear();
        for (int i = 0; i < data.length; i++) {
          raiseTicketList.add(SupportModel.fromJson(data[i]));
        }
      } else {
        print("Empty Data");
      }
    } catch (e) {
      print(e);
    }

  }

  void showResponseDialog(BuildContext context, String supportSideResponse, String customerSideResponse){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Responses"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(supportSideResponse),
              // onTap: () {
              //   Navigator.of(context).pop();
              // },
            ),
            ListTile(
              title: Text(customerSideResponse),
              // onTap: () {
              //   Navigator.of(context).pop();
              // },
            ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket History"),
        centerTitle: true,
      ),
      body: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.73,
                  child: raiseTicketList.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: raiseTicketList.length,
                          itemBuilder: (context, index) {

                            String supportSideResponse = raiseTicketList[index]['supportSideResponse'];
                            String customerSideResponse = raiseTicketList[index]['customerSideResponse'];

                            String status = raiseTicketList[index]['supportStatus'];
                            bool isCompleted = (status == 'completed');



                            return Opacity(
                              opacity: isCompleted ? 0.5 : 1.0, // Reduce opacity if completed
                              child: Card(
                                  elevation: 4,
                                  color: const Color.fromARGB(255, 243, 254, 255),
                                  margin: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.02),
                                  child: ListTile(
                                      onTap: () {
                                        showResponseDialog(context, supportSideResponse, customerSideResponse);
                                      },
                                      title: Text(
                                        raiseTicketList[index]['supportSubject'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04),
                                      ),
                                      subtitle: //container for station address
                                          Text(
                                        raiseTicketList[index]['supportDescription'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: isCompleted ? const Icon(Icons.done) : const Icon(Icons.incomplete_circle),
                                      leading: //column for 'distance from user' and connector type
                                        const Icon(Icons.support)
                                          )),
                            );
                          }),
                ),
    );
  }
}