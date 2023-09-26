import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:vcharge/view/stationsSpecificDetails/stationsSpecificDetails.dart';

import '../chargingScreen/chargingScreen.dart';

class QRScannerWidget extends StatefulWidget {
  String userId;
  QRScannerWidget({required this.userId, super.key});

  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  var stationCodeController = TextEditingController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scanStarted = false;
  String scanResult = " ";

  @override
  void initState() {
    super.initState();
    showScanner();
  }

  void showScanner() {
    setState(() {
      showScannerWidget = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

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

  bool isScanned = false;

  void onQRViewCreated(QRViewController controller) async {
    try {
      this.controller = controller;

      // Check for camera permission
      var status = await Permission.camera.status;
      if (!status.isGranted) {
        await Permission.camera.request();
        status = await Permission.camera.status;
      }

      if (status.isGranted) {
        controller.scannedDataStream.listen((scanData) async {
          if (isScanned) return;

          try {
            controller.stopCamera();

            scanResult = scanData.code!;
            print("Scanned Result: $scanResult");

            List<String> parts = scanResult.split(';');

            if (parts.length == 2) {
              String chargerSerialNumber = parts[0];
              String connectorNumber = parts[1];

              // Now you can use chargerSerialNumber and connectorNumber as needed
              print("Charger Serial Number: $chargerSerialNumber");
              print("Connector Number: $connectorNumber");

              // Navigate to Charging Screen with relevant data
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChargingScreen(
                    stationLocation: 'Kharadi',
                    stationName: 'Virtuoso Charging Station',
                    userId: widget.userId,
                    chargerSerialNumber: chargerSerialNumber,
                    connectorNumber: connectorNumber,
                  ),
                ),
              );
            } else {
              // Handle case where the content doesn't match the expected format
              print("Invalid QR Code Format");
              // Display an error message or take appropriate action
            }
          } catch (e) {
            print("Error while processing QR code: $e");
          } finally {
            isScanned = true;
          }
        });
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
      print("Error: $e");
    }
  }

  bool showScannerWidget = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        showScannerWidget = true;
      },
      child: Scaffold(
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
        body: Stack(
          children: [
            Visibility(
              visible: showScannerWidget,
              child: Positioned.fill(
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
            ),
            Visibility(
              visible: showScannerWidget,
              replacement: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          onTap: () {
                            showScannerWidget = false;
                          },
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
              ),
              child: Positioned(
                top: 100,
                left: (MediaQuery.of(context).size.width -
                        MediaQuery.of(context).size.width * 0.8) /
                    2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 195, 227, 196),
                        width: 3.0),
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
                            cutOutSize:
                                MediaQuery.of(context).size.width * 0.65,
                          ),
                          onQRViewCreated: onQRViewCreated,
                        ),
                ),
              ),
            ),
            Visibility(
              visible: showScannerWidget,
              child: Positioned(
                top: MediaQuery.of(context).size.height * 0.5 + 120,
                left: MediaQuery.of(context).size.width * 0.20,
                child: const Text(
                  "------------ OR ------------",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: showScannerWidget,
              child: Positioned(
                top: MediaQuery.of(context).size.height * 0.5 + 160,
                left: MediaQuery.of(context).size.width * 0.156,
                child: Column(
                  children: [
                    const Text(
                      "Please enter the station code as seen on the box",
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        onTap: () {
                          showScannerWidget = false;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10.0),
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
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StationsSpecificDetails(
                          userId: widget.userId,
                          stationId: 'STN20230905124347342')));
            },
            label: const Text(
              "Proceed",
            ),
          ),
        ),
      ),
    );
  }
}
