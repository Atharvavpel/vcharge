import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QrScannerScreen extends StatelessWidget {
  QrScannerScreen({super.key});

  // var for storing station code
  var stationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
        
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    child: const Text("Scan & Charge", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple
                    ),),
                  ),
                ),
              ),
              
              Expanded(
                flex:3,
                child: const Icon(Icons.qr_code_scanner, size: 200,)),
        
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: (){
                      
                  },
                  child: const Text("Click & Scan", style: TextStyle(
                    fontSize: 16
                  ),),
                ),
              ),
        
              Expanded(
                flex: 2,
                child: Container(
                  child: const Text("--------- OR ---------", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                ),
              ),

              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                        child: const Text("Please enter the station code as seen on the box", style: TextStyle(
                          fontSize: 15
                        ),),
                      ),
                      Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                              decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FaIcon(FontAwesomeIcons.gasPump,size: 20,color: Color.fromARGB(255, 51, 50, 50),),
                                ),
                                border: OutlineInputBorder(),
                                label: Text("Station Code"),
                              ),
                              controller: stationCodeController,
                            ),
                  ),
              
                  ],
                ),
              )
              
        
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 60),
        child: FloatingActionButton.extended(onPressed: (){
      
        }, label: const Text("Proceed",),
        ),
      ),
      
    );
  }
}