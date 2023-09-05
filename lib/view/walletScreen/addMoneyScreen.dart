import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    amountController.text = initialAmount;
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
    amountController.dispose();
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful: ${response.paymentId!}",
        timeInSecForIosWeb: 4);
    _addTransactionHistoryItem(
      amountController.text,
      "vCharge",
      "Adding Money to Wallet",
      true,
      response.paymentId!,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Error: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
    _addTransactionHistoryItem(
      amountController.text,
      "vCharge",
      "Adding Money to Wallet",
      false,
      null,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet: ${response.walletName}", timeInSecForIosWeb: 4);
  }

  void _addTransactionHistoryItem(String amount, String name,
      String description, bool isSuccess, String? orderId) async {
    String formattedTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final prefs = await SharedPreferences.getInstance();
    final transactionHistoryJson =
        prefs.getStringList('transactionHistory') ?? [];

    transactionHistoryJson.add(json.encode({
      'amount': amount,
      'name': name,
      'description': description,
      'isSuccess': isSuccess,
      'time': formattedTime,
      'orderId': orderId ?? '',
    }));

    await prefs.setStringList('transactionHistory', transactionHistoryJson);
  }

  void _startPayment() async {
    const String apiKey = 'rzp_test_QnFF8vfuGXu4oj';
    const String apiSecret = 'ke2710JK7jZrvyAvyQOIxeZ9';
    const String apiUrl = 'https://api.razorpay.com/v1/orders';

    final String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$apiKey:$apiSecret'));

    final Map<String, dynamic> orderData = {
      'amount': int.parse(amountController.text) * 100,
      'currency': 'INR',
      'receipt': 'order_receipt_${DateTime.now().millisecondsSinceEpoch}',
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': basicAuth,
      },
      body: json.encode(orderData),
    );

    if (response.statusCode == 200) {
      final orderResponse = json.decode(response.body);
      String orderId = orderResponse['id'];

      var options = {
        'key': apiKey,
        'amount': int.parse(amountController.text),
        'order_id': orderId,
        'name': 'vCharge',
        'description': 'Adding Money to Wallet',
      };

      _razorpay?.open(options);
    } else {
      throw Exception('Failed to create Razorpay order');
    }
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
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

                // Proceed to Add Button
                GestureDetector(
                  key: const Key('proceedToAddButton'),
                  onTap: () {
                    _startPayment();
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
