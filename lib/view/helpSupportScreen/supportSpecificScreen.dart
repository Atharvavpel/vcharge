

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:vcharge/view/helpSupportScreen/message.dart';

class SupportSpecificScreen extends StatefulWidget {

  String customerId;
  String title;
  String description;
  String supportSideResponse;
  String customerSideResponse;

  SupportSpecificScreen({super.key,required this.customerId, required this.title, required this.description, required this.customerSideResponse, required this.supportSideResponse});

  @override
  State<SupportSpecificScreen> createState() => _SupportSpecificScreenState();
}

class _SupportSpecificScreenState extends State<SupportSpecificScreen> {

  List<Message> messages = [];

  @override
  void initState() {
    super.initState();

  messages = [

    Message(
      text:  widget.supportSideResponse, 
      date: DateTime.now().subtract(const Duration(minutes: 1)), 
      isSentByMe: false
    ),
    Message(
      text:  widget.customerSideResponse, 
      date: DateTime.now().subtract(const Duration(minutes: 1)), 
      isSentByMe: true
    ),
    

  ];

  }


  @override
  Widget build(BuildContext context){

    return Scaffold(
  appBar: AppBar(
    title: const Text("Support"),
    centerTitle: true,
  ),
  body: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      Expanded(
        child: GroupedListView<Message, DateTime>(
          padding: const EdgeInsets.all(8),
          reverse: true,
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: true,
          floatingHeader: true,
          elements: messages,
          groupBy: (message) => DateTime(
            message.date.year,
            message.date.month,
            message.date.day,
          ),
          groupHeaderBuilder: (Message message) {
            return SizedBox(
            //   height: 40,
            //   child: Center(
            //     child: Card(
            //       color: Theme.of(context).primaryColor,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8),
            //         child: Text(
            //           DateFormat.yMMMd().format(message.date),
            //           style: const TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   ),
            );
          },
          itemBuilder: (context, Message message) {
          final isSentByMe = message.isSentByMe;
          final alignment = isSentByMe ? Alignment.bottomLeft : Alignment.bottomRight;
          final color = isSentByMe ? const Color.fromARGB(255, 231, 238, 223) : Colors.green;
  
  return Stack(
    children: [
      Align(
        alignment: alignment,
        child: Container(
          constraints: BoxConstraints(
            minWidth: Get.width* 0.2,
            maxWidth: MediaQuery.of(context).size.width * 0.75, 
          ),
          child: Card(
            color: color,
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                message.text,
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: isSentByMe ? null : 0,
        left: isSentByMe ? 0 : null,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: color,
          ),
        ),
      ),
    ],
  );
},

          // itemBuilder: (context, Message message){
          //   return Align(
          //   alignment:
          //       message.isSentByMe ? Alignment.bottomLeft : Alignment.bottomRight,
          //   child: Card(
          //     color: message.isSentByMe
          //         ? const Color.fromARGB(255, 231, 238, 223)
          //         : Colors.green,
          //     elevation: 8,
          //     child: Padding(
          //       padding: const EdgeInsets.all(20),
          //       child: Text(
          //         message.text,
          //         style: const TextStyle(fontSize: 10),
          //       ),
          //     ),
          //   ),
          //           );
          // }
        ),
      ),
      Container(
        child: TextField(
          textAlign: TextAlign.center,
          controller: TextEditingController(text: "We will contact you soon...."),
          readOnly: true,
        ),
      ),
    ],
  ),
);



    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Support"),
    //     centerTitle: true,
    //   ),
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [

    //       Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(15.0),
    //           child: Text(
    //             widget.title,
    //             style: const TextStyle(
    //               fontSize: 24,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 8),
    //         Padding(
    //           padding: const EdgeInsets.all(15.0),
    //           child: Text(
    //             widget.description,
    //             style: const TextStyle(
    //               fontSize: 16,
    //             ),
    //           ),
    //         ),
    //       ],
    //       ),

    //       Expanded(
    //         child: GroupedListView<Message,DateTime>(
    //           padding: const EdgeInsets.all(8),
    //           reverse: true,
    //           order: GroupedListOrder.DESC,
    //           useStickyGroupSeparators: true,
    //           floatingHeader: true,
    //           elements: messages,
    //           groupBy: (message) => DateTime(
    //             message.date.year,
    //             message.date.month,
    //             message.date.day
    //           ),
    //           groupHeaderBuilder: (Message message) => SizedBox(
    //             // height: 40,
    //             // child: Center(
    //             //   child: Card(
    //             //     color: Theme.of(context).primaryColor,
    //             //     child: Padding(
    //             //       padding: const EdgeInsets.all(8),
    //             //       child: Text(
                
    //             //         DateFormat.yMMMd().format(message.date),
    //             //         style: const TextStyle(color: Colors.white),
    //             //       ),
    //             //     ),
    //             //   ),
    //             // ),
    //           ),
    //           itemBuilder: (context, Message message) => Align(
    //             alignment: message.isSentByMe ? Alignment.topRight : Alignment.topLeft,
    //             child: Card(
    //               color: message.isSentByMe ? const Color.fromARGB(255, 231, 238, 223) : Colors.green,
    //               elevation: 8,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(20),
    //                 child: Text(message.text, style: const TextStyle(fontSize: 10),),
    //               ),
    //             ),
    //           )
    //         ),
    //       ),
    //       Container(
    //         child: TextField(  
    //           textAlign: TextAlign.center,
    //           controller: TextEditingController(text: "We will contact you soon...."),
    //           readOnly: true,
    //         )
    //       )
    //     ],
    //   ),
    // );
  }
}