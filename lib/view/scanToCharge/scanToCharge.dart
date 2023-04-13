import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vcharge/services/GetMethod.dart';

import '../startChargingScreen/startChargingScreen.dart';
import '../walletScreen/addMoneyScreen.dart';

class ScanToCharge extends StatefulWidget {
  String stationName;
  String stationLocation;
  String userId;

  ScanToCharge(
      {required this.userId,
      required this.stationLocation,
      required this.stationName,
      super.key});

  @override
  State<StatefulWidget> createState() => ScanToChargeState();
}

class ScanToChargeState extends State<ScanToCharge> {
  //activeButton to track time, units and money aciveness
  //1 = time, 2 = units and 3 = money
  int activeButton = 1;

  int timeSliderValue = 6;
  int unitsSliderValue = 100;
  int moneySliderValue = 1000;

  var walletAmount;

  @override
  void initState() {
    getWalletAmount();
    super.initState();
  }

  Future<void> getWalletAmount() async {
    var data = await GetMethod.getRequest(
        'http://192.168.0.41:8081/manageUser/getWallet?userId=${widget.userId}');
    if (data != null) {
      setState(() {
        walletAmount = data['walletAmount'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Charge'),
      ),
      body: Column(
        children: [
          //Expanded for station Name
          Expanded(
            flex: 6,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
                vertical: MediaQuery.of(context).size.width * 0.03,
              ),
              child: Text(
                widget.stationName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.06),
              ),
            ),
          ),

          //Container for address, car and bike, charger type, cost
          Expanded(
            flex: 14,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Container for station address
                  Container(
                    child: Row(
                      children: [
                        //container for location Icon
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: const Icon(Icons.directions),
                          ),
                        ),

                        //container for station address text
                        Expanded(
                          flex: 14,
                          child: Container(
                            child: Text(
                              widget.stationLocation,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Container for car name
                  Container(
                    child: Row(
                      children: [
                        //container for car or bike Icon
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: const Icon(Icons.electric_bike),
                          ),
                        ),
                        //conteiner for car or bike name
                        Expanded(
                          flex: 14,
                          child: Container(
                            child: const Text(
                              'Revolt RV 300',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Container for charger type
                  Container(
                    child: Row(
                      children: [
                        //container for charger icon
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: const Icon(Icons.charging_station),
                          ),
                        ),
                        //container for charger type and watt
                        Expanded(
                          flex: 14,
                          child: Container(
                            child: const Text(
                              'AC, 3.3 kWh',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Container for charging cost
                  Container(
                    child: Row(
                      children: [
                        //container for rupee icon
                        Expanded(
                          flex: 2,
                          child: Container(
                            child: const Icon(Icons.currency_rupee),
                          ),
                        ),
                        //container for cost price of charger
                        Expanded(
                          flex: 14,
                          child: Container(
                            child: const Text(
                              'Cost: 15 rs/kW',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Container for Time slider, Units slider and Money slider
          Expanded(
            flex: 32,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //Expanded for time, units and money buttons
                  Expanded(
                    flex: 10,
                    child: Container(
                      margin: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.01),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              width: 2,
                              color: const Color.fromARGB(255, 146, 204, 81))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //Button for time slider button
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: activeButton == 1 ? 4 : 0,
                                backgroundColor: activeButton == 1
                                    ? const Color.fromARGB(255, 146, 208, 80)
                                    : Colors
                                        .transparent, // Set the button color
                              ),
                              onPressed: () {
                                setState(() {
                                  activeButton = 1;
                                });
                              },
                              child: Text('Time',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: activeButton == 1
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255, 146, 208, 80)))),

                          //button for unit slider button
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: activeButton == 2 ? 4 : 0,
                                backgroundColor: activeButton == 2
                                    ? const Color.fromARGB(255, 146, 208, 80)
                                    : Colors
                                        .transparent, // Set the button color
                              ),
                              onPressed: () {
                                setState(() {
                                  activeButton = 2;
                                });
                              },
                              child: Text(
                                'Units',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: activeButton == 2
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 146, 208, 80)),
                              )),

                          //button for money slider button
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: activeButton == 3 ? 4 : 0,
                                backgroundColor: activeButton == 3
                                    ? const Color.fromARGB(255, 146, 208, 80)
                                    : Colors
                                        .transparent, // Set the button color
                              ),
                              onPressed: () {
                                setState(() {
                                  activeButton = 3;
                                });
                              },
                              child: Text(
                                'Money',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: activeButton == 3
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 146, 208, 80)),
                              )),
                        ],
                      ),
                    ),
                  ),

                  //constainer for 'How long will you charge ?' text
                  Expanded(
                    flex: 8,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.005),
                      child: Center(
                        child: Text(
                          'How long will you charge ?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 35,
                    child: Column(
                      children: [
                        activeButton == 1
                            ?
                            //Container for Time slider
                            Container(
                                height: Get.height * 0.25,
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.06),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 146, 204, 81)
                                            .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        //Container for set limit text
                                        Container(
                                          child: Text(
                                            'Set Limit',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                            ),
                                          ),
                                        ),
                                        //silder
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor:
                                                const Color.fromARGB(
                                                    255, 146, 204, 81),
                                            inactiveTrackColor: Colors.grey,
                                            thumbColor: const Color.fromARGB(
                                                255, 146, 204, 81),
                                            overlayColor: const Color.fromARGB(
                                                    255, 146, 204, 81)
                                                .withOpacity(0.2),
                                          ),
                                          child: SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                              valueIndicatorColor:
                                                  const Color.fromARGB(
                                                      255, 146, 204, 81),
                                              valueIndicatorTextStyle:
                                                  const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Slider(
                                              min: 1,
                                              max: 6,
                                              divisions: 6,
                                              inactiveColor: const Color.fromARGB(
                                                  255, 191, 235, 141),
                                              activeColor: const Color.fromARGB(
                                                  255, 146, 204, 81),
                                              value: timeSliderValue.toDouble(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  timeSliderValue =
                                                      newValue.toInt();
                                                });
                                              },
                                              label: '${timeSliderValue
                                                      .toStringAsFixed(0)}hr',
                                            ),
                                          ),
                                        ),
                                        //container to show the selected value
                                        Container(
                                          child: Text(
                                            '$timeSliderValue hours',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                                color: const Color.fromARGB(
                                                    255, 146, 204, 81)),
                                          ),
                                        ),
                                      ]),
                                ),
                              )
                            : activeButton == 2
                                ?
                                //Container for Units slider
                                Container(
                                    height: Get.height * 0.25,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                                255, 146, 204, 81)
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                        //container for set limit text
                                        Container(
                                          child: Text(
                                            'Set Limit',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                            ),
                                          ),
                                        ),
                                        //slider
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor:
                                                const Color.fromARGB(
                                                    255, 146, 204, 81),
                                            inactiveTrackColor: Colors.grey,
                                            thumbColor: const Color.fromARGB(
                                                255, 146, 204, 81),
                                            overlayColor: const Color.fromARGB(
                                                    255, 146, 204, 81)
                                                .withOpacity(0.2),
                                          ),
                                          child: SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                              valueIndicatorColor:
                                                  const Color.fromARGB(
                                                      255, 146, 204, 81),
                                              valueIndicatorTextStyle:
                                                  const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Slider(
                                              min: 1,
                                              max: 100,
                                              divisions: 20,
                                              inactiveColor: const Color.fromARGB(
                                                  255, 191, 235, 141),
                                              activeColor: const Color.fromARGB(
                                                  255, 146, 204, 81),
                                              value:
                                                  unitsSliderValue.toDouble(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  unitsSliderValue =
                                                      newValue.toInt();
                                                });
                                              },
                                              label: unitsSliderValue
                                                      .toStringAsFixed(0) +
                                                  'units',
                                            ),
                                          ),
                                        ),

                                        //container to show the selected value
                                        Container(
                                          child: Text(
                                            '$unitsSliderValue Units',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.06,
                                                color: const Color.fromARGB(
                                                    255, 146, 204, 81)),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  )
                                :
                                //Container for Money slider
                                Container(
                                    height: Get.height * 0.25,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.06),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                                255, 146, 204, 81)
                                            .withOpacity(0.2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                        //container for set limit text
                                        Container(
                                          child: Text(
                                            'Set Limit',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.06,
                                            ),
                                          ),
                                        ),
                                        //slider
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor:
                                                const Color.fromARGB(
                                                    255, 146, 204, 81),
                                            inactiveTrackColor: Colors.grey,
                                            thumbColor: const Color.fromARGB(
                                                255, 146, 204, 81),
                                            overlayColor: const Color.fromARGB(
                                                    255, 146, 204, 81)
                                                .withOpacity(0.2),
                                          ),
                                          child: SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
                                              valueIndicatorColor:
                                                  const Color.fromARGB(
                                                      255, 146, 204, 81),
                                              valueIndicatorTextStyle:
                                                  const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Slider(
                                              min: 100,
                                              max: 1000,
                                              divisions: 9,
                                              inactiveColor: const Color.fromARGB(
                                                  255, 191, 235, 141),
                                              activeColor: const Color.fromARGB(
                                                  255, 146, 204, 81),
                                              value:
                                                  moneySliderValue.toDouble(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  moneySliderValue =
                                                      newValue.toInt();
                                                });
                                              },
                                              label: moneySliderValue
                                                      .toStringAsFixed(0) +
                                                  ' Rs',
                                            ),
                                          ),
                                        ),

                                        //container to show the selected value
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$moneySliderValue',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                    color: const Color.fromARGB(
                                                        255, 146, 204, 81)),
                                              ),
                                              const Icon(Icons.currency_rupee)
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Container for estimated price
          Expanded(
            flex: 6,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Estimated Price:'),
                  Text('Rs 200 Inc Taxes', style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),

          //Container for wallet balance and credit button
          Expanded(
            flex: 6,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.height * 0.004),
              decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Text('Wallet balance is '),
                        //rupees icon
                        Icon(
                          Icons.currency_rupee,
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                        walletAmount == null
                            ? const CircularProgressIndicator()
                            : Text(
                                walletAmount!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045),
                              ),
                      ],
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 146, 204, 81)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddMoneyScreen(userId: widget.userId)));
                        },
                        child: const Text('Credit'))
                  ],
                ),
              ),
            ),
          ),

          //Container for start charging button
          Expanded(
            flex: 8,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06, vertical: Get.height * 0.02),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 146, 204, 81)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StartChargingScreen()));
                  },
                  child: const Text('Start Charging')),
            ),
          )
        ],
      ),
    ));
  }
}
