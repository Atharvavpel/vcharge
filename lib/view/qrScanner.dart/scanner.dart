
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vcharge/view/qrScanner.dart/qrScannerOutput.dart';
import 'package:vcharge/view/startChargingScreen/startChargingScreen.dart';
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';

import '../chargingScreen/chargingScreen.dart';

class QRScannerWidget extends StatefulWidget {
  String userId;
  QRScannerWidget({required this.userId,super.key});

  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  
  // controller for taking input the stationCode
  var stationCodeController = TextEditingController();

  // this is the global key variable which is used to access this qrKey from anywher in the entire app
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // this is the controller which is used to handle the scanning events of the qr scanner
  QRViewController? controller;

  // boolean var which is used to keep the track of whether the screen is open or not
  bool scanStarted = false;

  // variable for keeping the track of scan outputs
  String scanResult = " ";


  @override
  void initState() {
    super.initState();
  }

// dispose method which is used to handle the widgets which are not mounted
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

// method which handles the events for starting the scanner
  void startScanner() async {
    try {
      if (controller != null) {
      await controller?.resumeCamera();
      setState(() {
        scanStarted = true;
      });
    }
    } catch (e) {
      print("The error at the scanner is: $e");
    }
  }

// method which handles the events for stopping the scanner
  void stopScanner() async {
    try {
      if (controller != null) {
      await controller?.pauseCamera();
      setState(() {
        scanStarted = false;
      });
    }
    } catch (e) {
      print(e);
    }
  }

  // method for storing bar code result
  void _onQRViewCreated(QRViewController controller) async {

    try {
      this.controller = controller;

    // Check for camera permission
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
      status = await Permission.camera.status;
    }

    if (status.isGranted) {
      try {
        controller.scannedDataStream.listen((scanData) async {
          // controller.pauseCamera();
          controller.stopCamera();


  //         // Decrypt the scanned data
  // final key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  // final iv = IV.fromLength(16);
  // final encrypter = Encrypter(AES(key));
  // final decrypted = encrypter.decrypt64(scanData as String, iv: iv);

  // // Navigate to the output page and pass the decrypted data as a parameter
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(builder: (context) => QrScannerOutput(output: decrypted)),
  // );

          scanResult = scanData.code!;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => QrScannerOutput(output: scanResult),
          //   ),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChargingScreen(stationLocation: 'Kharadi, Pune', stationName: 'EV Charging station', userId: widget.userId, chargerId: scanResult,),
            ),
          );
          await controller.resumeCamera();
        });
      } on PlatformException {
        setState(() {
          scanResult = "Failed to scan";
        });
      }
    } else {

      // Handle denied permission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera permission denied'),
          duration: Duration(seconds: 1),
        ),
      );
    }
    } catch (e) {
      print("the error is: $e");
    }

    
  }

// build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 78, 230, 164),
        centerTitle: true,
        title: const Text(
          "Scan and Charge",
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
      extendBodyBehindAppBar: true,

      // container for qr scanner
      body: Stack(
        children: [

// background overlay effect
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                  stops: const [0.0, 0.2, 0.8, 1.0],
                ),
              ),
            ),
          ),

// qr scanner widget
          Positioned(
            top: 100,
            left: (MediaQuery.of(context).size.width -
                    MediaQuery.of(context).size.width * 0.8) /
                2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 195, 227, 196), width: 3.0),
              ),
              child: (scanResult == "Failed to scan")
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.qr_code_scanner,
                          color: Colors.white, size: 60.0),
                      SizedBox(height: 16.0),
                      Text("Failed to scan, please enter the station Id",
                          style: TextStyle(
                              color: Colors.white, fontSize: 16.0)),
                    ],
                  )
                  : QRView(
                      key: qrKey,
                      cameraFacing: CameraFacing.back,
                      overlay: QrScannerOverlayShape(
                        borderRadius: 16.0,
                        borderColor: Colors.white,
                        borderLength: 24.0,
                        borderWidth: 4.0,
                        cutOutSize: MediaQuery.of(context).size.width * 0.65,
                      ),
                      onQRViewCreated: _onQRViewCreated,
                    ),
            ),
          ),

// Text - "OR";
          Positioned(
              top: MediaQuery.of(context).size.height * 0.5 + 120,
              left: MediaQuery.of(context).size.width * 0.27,
              child: const Text(
                "------------ OR ------------",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              )),

// widget for Station code textfield              
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5 + 160,
            left: MediaQuery.of(context).size.width * 0.156,
            child: Column(
              children: [
                const Text(
                  "Please enter the station code as seen on the box",
                  style: TextStyle(fontSize: 10),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(9.0),
                          child: FaIcon(
                            FontAwesomeIcons.gasPump,
                            size: 20,
                            color: Color.fromARGB(255, 51, 50, 50),
                          ),
                        ),
                        border: OutlineInputBorder(),
                        label: Text("Station Code"),
                      ),
                      controller: stationCodeController,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),

// submit button      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => StationsSpecificDetails(userId: widget.userId, stationId: 'STN20230505105447818')));
          },
          label: const Text(
            "Proceed",
          ),
        ),
      ),
    );
  }
}
