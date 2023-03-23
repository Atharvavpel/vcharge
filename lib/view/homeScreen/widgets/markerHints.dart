import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MarkerHints extends StatefulWidget {
  @override
  State<MarkerHints> createState() => _MarkerHintsState();
}

class _MarkerHintsState extends State<MarkerHints> {
  //Vairiable to store the tapPosition Details
  // Offset tapPosition = Offset.zero;

  // //this function will get the tapped position and store the Offset position into our tapPosition global variable
  // void getTapPosition(TapDownDetails tapposition) {
  //   final RenderBox renderBox = context.findRenderObject() as RenderBox;
  //   setState(() {
  //     tapPosition = renderBox.globalToLocal(tapposition.localPosition);
  //   });
  //   print(tapPosition);
  // }

  // void showPopup(context) async {
  //   //here we need to create am overlay because, we want tha our popup should pop on front
  //   //by this we can show that popup box on top of any widget
  //   // final RenderObject? overlay =
  //   //     Overlay.of(context).context.findRenderObject();
  //   final result = await Positioned(
  //     left: tapPosition.dx,
  //     top: tapPosition.dy,
  //     child: Wrap(children: [
  //       //Row For Available
  //       Row(
  //         children: const [
  //           Expanded(
  //             flex: 2,
  //             child: CircleAvatar(
  //               backgroundColor: Colors.green,
  //               radius: 10,
  //             ),
  //           ),
  //           Expanded(
  //               flex: 5,
  //               child: Text(
  //                 'Available',
  //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //               )),
  //         ],
  //       ),

  //       const SizedBox(
  //         width: 1,
  //         height: 5,
  //       ),

  //       //Row For Busy
  //       Row(
  //         children: const [
  //           Expanded(
  //             flex: 2,
  //             child: CircleAvatar(
  //               backgroundColor: Colors.orange,
  //               radius: 10,
  //             ),
  //           ),
  //           Expanded(
  //               flex: 5,
  //               child: Text(
  //                 'Busy',
  //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //               )),
  //         ],
  //       ),

  //       const SizedBox(
  //         width: 1,
  //         height: 5,
  //       ),

  //       //Row For Not Available
  //       Row(
  //         children: const [
  //           Expanded(
  //             flex: 2,
  //             child: CircleAvatar(
  //               backgroundColor: Colors.red,
  //               radius: 10,
  //             ),
  //           ),
  //           Expanded(
  //               flex: 5,
  //               child: Text(
  //                 'Not Available',
  //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
  //               )),
  //         ],
  //       ),
  //     ]),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(blurRadius: 5, color: Colors.grey, spreadRadius: 1)
      ], borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.only(right: 13, bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: GestureDetector(
          // onTapDown: (position) {
          //   getTapPosition(position);
          // },
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Wrap(children: [

                      
                      //Row For Available
                      Row(
                        children: const [
                          Expanded(
                            flex: 2,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 8,
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Text(
                                'Available',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),

                      const SizedBox(
                        width: 1,
                        height: 5,
                      ),


                      //Row For Busy
                      Row(
                        children: const [
                          Expanded(
                            flex: 2,
                            child: CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 8,
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Text(
                                'Busy',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),

                      const SizedBox(
                        width: 1,
                        height: 5,
                      ),


                      //Row For Not Available
                      Row(
                        children: const [
                          Expanded(
                            flex: 2,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 8,
                            ),
                          ),
                          Expanded(
                              flex: 5,
                              child: Text(
                                'Not Available',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ]),
                  );
                });
          },

          child: const FaIcon(
            FontAwesomeIcons.question,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

