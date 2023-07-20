/*

as you know, i have three buttons in the bottom navigation bar, default app opens at the index = 1 
button and at index = 0, there is a list of all stations page and index = 2, has the qr scanner
page. What i want is, when i am at the scanner page or say the list of all stations page, 
once user clicks the back button which comes by default on the android, it should come back to the home button
which is by default set and it should not terminate the application and close it.

*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vcharge/models/transactionModel.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:intl/intl.dart';
import 'package:vcharge/view/walletScreen/addMoneyScreen.dart';

import '../../models/walletModel.dart';

// ignore: must_be_immutable
class WalletScreen extends StatefulWidget {
  String? userId;

  WalletScreen({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  WalletModel? walletDetail;
  List<TransactionModel> transactionData = [];

  //user name
  var userFirstName = "...";
  var userLastName = "...";

  @override
  void initState() {
    getUserName();
    getWalletDetails();
    getTransactionDetails();
    super.initState();
  }

  Future<void> getUserName() async {
    try {
      var data = await GetMethod.getRequest(
          'http://192.168.0.243:8097/manageUser/getUserByUserId?userId=${widget.userId}');
      if (data != null) {
        setState(() {
          userFirstName = data['userFirstName'];
          userLastName = data['userLastName'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  //fetch the wallet details according to userId and store it to walletDetail variable
  Future<void> getWalletDetails() async {
    try {
      var data = await GetMethod.getRequest(
          "http://192.168.0.243:8097/manageUser/getWallet?userId=${widget.userId}");

      // print(data);
      setState(() {
        walletDetail = WalletModel(
            walletAmount: data['walletAmount'].toString(),
            walletCurrency: data['walletCurrency'],
            walletStatus: data['walletStatus']);
      });
    } catch (e) {
      print(e);
    }
  }

  //this function fetch the transaction details according to userId and store it to transactionData list
  Future<void> getTransactionDetails() async {
    try {
      var data = await GetMethod.getRequest(
          'http://192.168.0.243:8097/manageUser/getTransaction?userId=${widget.userId}');
      setState(() {
        if (data != null) {
          for (int i = 0; i < data.length; i++) {
            transactionData.add(TransactionModel(
              initiateTransactionDate: data[i]['initiateTransactionDate'],
              completeTransactionDate: data[i]['completeTransactionDate'],
              initiateTransactionTime: data[i]['initiateTransactionTime'],
              completeTransactionTime: data[i]['completeTransactionTime'],
              transactionAmount: data[i]['transactionAmount'].toString(),
              transactionUTR: data[i]['transactionUTR'],
              transactionStatus: data[i]['transactionStatus'],
              createdDate: data[i]['createdDate'],
            ));
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }

  //this function returns an icon based on given status
  IconData getStatusIcon(String status) {
    if (status.trim().toLowerCase() == 'complete') {
      return Icons.done;
    } else if (status.trim().toLowerCase() == 'pending') {
      return Icons.pending;
    } else {
      return Icons.cancel;
    }
  }

  //this function returns a color based on given status
  MaterialColor getStatusColor(String status) {
    if (status.trim().toLowerCase() == 'completed') {
      return Colors.green;
    } else if (status.trim().toLowerCase() == 'pending') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Wallet'),
        ),
        body: Wrap(
          children: [
            //Column for Head text (name and welcome)
            Container(
              margin: const EdgeInsets.all(15),
              child: Wrap(
                spacing: MediaQuery.of(context).size.width * 0.03,
                direction: Axis.vertical,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.02),
                    child: Text(
                      'Hi, $userFirstName $userLastName',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.14),
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

            //Container for available balance and others options
            Container(
              margin: const EdgeInsets.all(15),
              child: Card(
                color: const Color.fromARGB(255, 246, 255, 255),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 25, bottom: 25, right: 8, left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Icon of wallet
                      const FaIcon(
                        FontAwesomeIcons.wallet,
                        size: 45,
                        color: Color.fromARGB(255, 130, 199, 85),
                      ),

                      //Column for available balance
                      Column(
                        children: [
                          const Text(
                            'Available Balance',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          walletDetail == null
                              ? const CircularProgressIndicator()
                              : Row(
                                  children: [
                                    const Icon(Icons.currency_rupee_sharp),
                                    Text('${walletDetail!.walletAmount}')
                                  ],
                                )
                        ],
                      ),

                      //Container for credit button
                      ElevatedButton(
                        key: const Key('creditButton'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 130, 199, 85),
                          elevation: 5, // set the elevation value
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddMoneyScreen(
                                        userId: widget.userId,
                                      )));
                        },
                        child: const Text('Credit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //Container for transaction heading
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 130, 199, 85)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  'Transactions',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.06),
                )),
              ),
            ),

            //Container for listview
            SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.015),
                child: transactionData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        // shrinkWrap: true,
                        itemCount: transactionData.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: getStatusColor(
                                    transactionData[index].transactionStatus!)
                                .shade50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5,
                            child: ListTile(
                              //on tap function on listtile
                              onTap: () {},

                              //leading for transaction status
                              leading: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Center(
                                  child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.035,
                                      backgroundColor: getStatusColor(
                                          transactionData[index]
                                              .transactionStatus!),
                                      child: Icon(
                                        getStatusIcon(transactionData[index]
                                            .transactionStatus!),
                                        color: Colors.white,
                                      )),
                                ),
                              ),

                              // title for transaction amount
                              title: Row(
                                children: [
                                  Icon(
                                    Icons.currency_rupee,
                                    size: MediaQuery.of(context).size.width *
                                        0.06,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    '${transactionData[index].transactionAmount}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.055,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(2.0, 2.0),
                                          blurRadius: 3.0,
                                          color: Colors.grey.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              //subtitle for transaction date
                              subtitle: Text(
                                DateFormat('MMMM d, yyyy').format(
                                    DateFormat('yyyy/MM/dd').parse(
                                        transactionData[index]
                                            .completeTransactionDate!)),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.034),
                              ),

                              //trailing for payment method
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Payment method',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),
                                  Text(
                                    'Wallet',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
Card(
                          elevation: 5,
                          color: const Color.fromARGB(255, 246, 255, 255),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                //Expanded for transaction amount
                                Expanded(
                                    flex: 3,
                                    child: Wrap(
                                      runAlignment: WrapAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.currency_rupee,
                                          size:
                                              MediaQuery.of(context).size.width *
                                                  0.05,
                                        ),
                                        Text(
                                          '${transactionData[index].transactionAmount}',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width *
                                                  0.042,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                      
                                //Expanded for transaction Date
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${DateFormat('MMM d, y').format(DateFormat('dd-MM-yyyy').parse(transactionData[index].completeTransactionDate!))}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.034),
                                  ),
                                ),
                      
                                //Expanded for transaction Status
                                Expanded(
                                  flex: 3,
                                  child: Wrap(
                                    runSpacing:
                                        MediaQuery.of(context).size.height *
                                            0.008,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text(
                                        'Status',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.of(context).size.width *
                                                  0.034,
                                        ),
                                      ),
                                      Text(
                                        '${transactionData[index].transactionStatus}',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.width *
                                                  0.04,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                      
                                //Expanded for payment method
                                Expanded(
                                  flex: 4,
                                  child: Wrap(
                                    runSpacing:
                                        MediaQuery.of(context).size.height *
                                            0.008,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text(
                                        'Payment method',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              MediaQuery.of(context).size.width *
                                                  0.034,
                                        ),
                                      ),
                                      Text(
                                        'wallet',
                                        style: TextStyle(
                                          fontSize:
                                              MediaQuery.of(context).size.width *
                                                  0.04,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
*/


/*
My design :


Card(
                          color: getStatusColor(transactionData[index].transactionStatus!).shade50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          child: ListTile(
                            //on tap function on listtile
                            onTap: () {},
    
                            //leading for transaction status
                            leading: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: CircleAvatar(
                                    radius: MediaQuery.of(context).size.width * 0.035,
                                    backgroundColor: getStatusColor(
                                        transactionData[index].transactionStatus!),
                                    child: Icon(
                                      getStatusIcon(
                                          transactionData[index].transactionStatus!),
                                      color: Colors.white,
                                    )),
                              ),
                            ),
    
                            // title for transaction amount
                            title: Row(
                              children: [
                                Icon(
                                  Icons.currency_rupee,
                                  size: MediaQuery.of(context).size.width * 0.06,
                                  color: Colors.black,
                                ),
                                Text(
                                  '${transactionData[index].transactionAmount}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.055,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(2.0, 2.0),
                                        blurRadius: 3.0,
                                        color: Colors.grey.withOpacity(0.4),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
    
                            //subtitle for transaction date
                            subtitle: Text(
                              DateFormat('MMMM d, y').format(
                                  DateFormat('dd-MM-yyyy').parse(
                                      transactionData[index]
                                          .completeTransactionDate!)),
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.034),
                            ),
    
                            //trailing for payment method
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Payment method',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.04,
                                  ),
                                ),
                                Text(
                                  'Wallet',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width * 0.04,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
*/