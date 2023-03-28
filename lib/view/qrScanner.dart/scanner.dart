// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class ScannerQrScreen extends StatefulWidget {
//   const ScannerQrScreen({Key? key}) : super(key: key);

//   @override
//   _ScannerQrScreenState createState() => _ScannerQrScreenState();
// }

// class _ScannerQrScreenState extends State<ScannerQrScreen> {
//   Future<String> _barcodeScanResFuture = Future.value('');

//   Future<void> scanBarcode() async {
//     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//       "#ff6666", // Color for the scanner overlay
//       "Cancel", // Text for the cancel button
//       true, // Show flash icon
//       ScanMode.BARCODE, // Specify the type of scan (barcode or QR code)
//     );

//     setState(() {
//       _barcodeScanResFuture = Future.value(barcodeScanRes);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code Scanner'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FutureBuilder(
//               future: _barcodeScanResFuture,
//               builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}');
//                   } else {
//                     return Text('Scan Result: ${snapshot.data}');
//                   }
//                 } else {
//                   return Text('Press the button to scan a barcode.');
//                 }
//               },
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: scanBarcode,
//               child: Text("Scan Barcode"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class ScannerQr {
//   Future<String> scanBarcode() async {
//     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//       "#ff6666", // Color for the scanner overlay
//       "Cancel", // Text for the cancel button
//       true, // Show flash icon
//       ScanMode.BARCODE, // Specify the type of scan (barcode or QR code)
//     );

//     // Do something with the scan result
//     print(barcodeScanRes);
//     return barcodeScanRes;
//   }
// }



// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class ScannerQr {

//   String result = " ";

//   static Future qrScanner() async {

//     try{
//       final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'cancel', true, ScanMode.QR);

//       print(qrCode);
//     }
//     on PlatformException {
//       print("failed to scan the qr code");
//     }

//   }

// }


// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class ScannerQr extends StatelessWidget {
//   const ScannerQr({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.brown,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vcharge/view/qrScanner.dart/qrScannerOutput.dart';

class QRScannerWidget extends StatefulWidget {
  @override
  _QRScannerWidgetState createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {

  // this is the global key variable which is used to access this qrKey from anywher in the entire app
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // this is the controller which is used to handle the scanning events of the qr scanner
  QRViewController? controller;

  // boolean var which is used to keep the track of whether the screen is open or not
  bool scanStarted = false;

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
    if (controller != null) {
      await controller?.resumeCamera();
      setState(() {
        scanStarted = true;
      });
    }
  }

// method which handles the events for stopping the scanner
  void stopScanner() async {
    if (controller != null) {
      await controller?.pauseCamera();
      setState(() {
        scanStarted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Stack (
        children: [
          
          Positioned(
            top: 50,
            left: MediaQuery.of(context).size.height * 0.05,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
          ),
      
        ],
      )
      
      
      
    /*  
      
      
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.9,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ElevatedButton(
                child: Text(scanStarted ? "Stop" : "Start"),
                onPressed: () {
                  if (scanStarted) {
                    stopScanner();
                  } else {
                    startScanner();
                  }
                },
              ),
            ),
          ),
        ],
      ),


*/


    );
  }

  void _onQRViewCreated(QRViewController controller) async {
  this.controller = controller;

  // Check for camera permission
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
    status = await Permission.camera.status;
  }

  if (status.isGranted) {
    
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QrScannerOutput(output: scanData.code),
      ),
    );
    print(scanData.code);
    await controller.resumeCamera();
    });
  } else {
    // Handle denied permission
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Camera permission denied'),
      ),
    );
  }
}


}
