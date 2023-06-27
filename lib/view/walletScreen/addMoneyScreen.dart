import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vcharge/view/walletScreen/widgets/addMoneyStatusPopUp.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AddMoneyScreen extends StatefulWidget {
  String? userId;

  AddMoneyScreen({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => AddMoneyScreenState();
}

class AddMoneyScreenState extends State<AddMoneyScreen> {
  //this amount is initial amount in text field
  String initialAmount = "1000";

  var amountController = TextEditingController();

  @override
  void initState() {
    amountController.text = initialAmount;
    super.initState();
  }

  //this function add the amount to current amount of amountController to the, and if the amountController is empty, it initialize the value of amountController with the given amount
  void addToAmountController(int amount) {
    setState(() {
      if (amountController.text.isNotEmpty) {
        int addedAmount = int.parse(amountController.text) + amount;
        amountController.text = addedAmount.toString();
      } else {
        amountController.text = amount.toString();
      }
    });
  }

  void startTransaction(String amount) async {
    Map<String, dynamic> body = {
      'amount': amount,
    };
    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    try {
      var res = await http.post(
          Uri.https(
            '192.168.0.238',
            "paytmPhp/initiate_transaction.php",
          ),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: formData);

      print(res.body);
      print(res.statusCode);

      if (res.statusCode == 200) {
        var bodyJson = jsonDecode(res.body);

        var response = AllInOneSdk.startTransaction(bodyJson['mid'],
            bodyJson['orderId'], amount, bodyJson['txToken'], "", true, false);
        response.then((value) {
          print(value);
          //on payment completion we will verigy transaction with transaction verify API
          verifyTransaction(bodyJson['orderId']);
          // setState(() {
          //   result = value.toString();
          // });
        }).catchError((error, stackTrace) {
          print("${error}");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.message)));
        });
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: "$e",
          // msg: "Successfully Created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void verifyTransaction(String orderId) async {
    Map<String, dynamic> body = {
      'orderId': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
        Uri.http('192.168.0.238', 'paytmPhp/transaction_status.php'),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: formData);

    print(res.body);
    print(res.statusCode);

    var verifyJson = jsonDecode(res.body);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(verifyJson['body']['resultInfo']['resultMsg'])));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () {
        // Remove focus from text field when the user taps outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Wallet'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //container for image
              Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                // width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.25,
                child: SvgPicture.asset('assets/images/addMoney.svg'),
              ),

              // Title text -> Add Money to Wallet
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Add Money To Wallet',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              // container for amount input
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.03,
                    right: MediaQuery.of(context).size.width * 0.03),
                child: Card(
                  child: Column(
                    children: [
                      //Container for text field
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Card(
                          elevation: 5,
                          child: TextField(
                            key: const Key('amountTextField'),
                            controller: amountController,
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.07,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter Amount',
                              prefixIcon: Icon(Icons.currency_rupee),
                            ),
                          ),
                        ),
                      ),

                      //Row for buttons which add a specific ammount
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //button for add 100
                            ElevatedButton(
                                key: const Key('add100Button'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  addToAmountController(100);
                                },
                                child: const Text(
                                  '+100',
                                  style: TextStyle(color: Colors.black),
                                )),

                            //button for add 500
                            ElevatedButton(
                                key: const Key('add500Button'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  addToAmountController(500);
                                },
                                child: const Text(
                                  '+500',
                                  style: TextStyle(color: Colors.black),
                                )),

                            //button for add 1000
                            ElevatedButton(
                                key: const Key('add1000Button'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  addToAmountController(1000);
                                },
                                child: const Text(
                                  '+1000',
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Proceed to Add Button
              GestureDetector(
                key: const Key('proceedToAddButton'),
                onTap: () {
                  startTransaction(amountController.text);
                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AddMoneyStatusPopUp(
                  //           addedAmount: amountController.text,
                  //           userId: widget.userId);
                  //     });
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.94,
                  child: Card(
                      color: const Color.fromARGB(255, 130, 199, 85),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Text(
                          'Proceed to Add',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.048,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
