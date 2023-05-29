


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

  String supportUrl = "http://192.168.0.243:8091/manageSupport/getSupportByCustomerId?supportCustomerId=USR20230517060841379";

  //this list store the list of stations
  List<SupportModel> raiseTicketList = [];

  @override
  void initState() {
    // TODO: implement initState
    getAllSupport();
    super.initState();
  }

  Future<void> getAllSupport() async {
    print("in get support function");
    try {
      var data = await GetMethod.getRequest(supportUrl);
      setState(() {
  if (data.isNotEmpty) {
    for (int i = 0; i < data.length; i++) {
      raiseTicketList.add(SupportModel.fromJson(data[i]));
      print(SupportModel.fromJson(data[i]));
      
    }
  } else {
    print("Empty Data");
  }
});
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
              title: Text("OUR RESPONSE: $supportSideResponse"),
              // onTap: () {
              //   Navigator.of(context).pop();
              // },
            ),
            ListTile(
              title: Text("YOUR RESPONSE: $customerSideResponse"),
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
                            var data = raiseTicketList[index];
                            String supportSideResponse = data.supportSideResponse.toString();
                            String customerSideResponse = data.customerSideResponse.toString();

                            String status = data.supportStatus.toString();
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
                                        data.supportSubject.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04),
                                      ),
                                      subtitle: //container for station address
                                          Text(
                                        data.supportDescription.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: isCompleted ? const Icon(Icons.done) : const Icon(Icons.incomplete_circle),
                                      leading: //column for 'distance from user' and connector type
                                        const Icon(Icons.call)
                                          )),
                            );
                          }),
                ),
    );
  }
}