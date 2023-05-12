import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/stopChargingAlertPopup.dart';

class StartChargingScreen extends StatefulWidget {
  const StartChargingScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartChargingScreenState();
}

class StartChargingScreenState extends State<StartChargingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Start Charging'),
        ),
        body: Column(
          children: [
            //Container for bike/car name and charge text
            SizedBox(
                height: Get.height * 0.15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Revolt RV 300',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * 0.05)),
                    Text(
                      'Your Bike is being charged',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Get.width * 0.06,
                          color: Colors.green),
                    )
                  ],
                )),

            //Container for charging indicator (circulat avatar)
            SizedBox(
              height: Get.height * 0.4,
              child: Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200)),
                  elevation: 6,
                  child: CircleAvatar(
                    radius: Get.height * 0.16,
                    backgroundColor:
                        const Color.fromARGB(255, 238, 255, 254),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '58 %',
                            style: TextStyle(fontSize: Get.width * 0.075),
                          ),
                          const Text(
                            'Charged',
                            style: TextStyle(color: Colors.green),
                          )
                        ]),
                  ),
                ),
              ),
            ),

            //Container for estimated time and price
            SizedBox(
              height: Get.height * 0.15,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Column for estimated time
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              '21 Mins',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Get.width * 0.06),
                            ),
                            const Text(
                              'Estimated time for a full charge',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),

                    //Column for estimated price
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: Get.width * 0.06,
                                ),
                                Text(
                                  '200',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Get.width * 0.06),
                                ),
                              ],
                            ),
                            const Text('Estimated cost for a full charge',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Container for stop button
            Container(
              width: Get.width * 0.3,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 154, 208, 83),
                      width: 2),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(Get.width * 0.05),
              child: InkWell(
                onTap: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return StopChargingAlertPopUp();
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.stop,
                        size: Get.width * 0.08,
                        color: const Color.fromARGB(255, 154, 208, 83),
                      ),
                      Text(
                        'Stop',
                        style: TextStyle(
                            fontSize: Get.width * 0.06,
                            color: const Color.fromARGB(255, 154, 208, 83)),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
