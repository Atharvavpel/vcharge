import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vcharge/services/GetMethod.dart';

class AddMoneyStatusPopUp extends StatefulWidget {
  String? addedAmount;
  String? userId;

  AddMoneyStatusPopUp(
      {required this.addedAmount, required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => AddMoneyStatusPopUpState();
}

class AddMoneyStatusPopUpState extends State<AddMoneyStatusPopUp> {
  //variable to store the wallet amount
  var walletAmount;

  @override
  void initState() {
    getWalletAmount();
    super.initState();
  }

  //The following function get the wallet amount store it in walletAmount variable
  Future<void> getWalletAmount() async {
    var data = await GetMethod.getRequest(
        'http://192.168.0.41:8081/manageUser/getWallet?userId=${widget.userId}');
    if (data != null) {
      setState(() {
        walletAmount = data['walletAmount'];
      });
    }
  }

  //this function takes hour as input and return, AM or PM according to that hour
  // String getAMorPM(var hour){
  //   // int hours = int.parse(hour);
  //   if(hour<12){
  //     return 'AM';
  //   }else{
  //     return 'PM';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Wrap(
        children: [
          //container for the top icon
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.1,
              //this stack consist of a container with a color and a icon in center
              child: Stack(
                children: [
                  //container has half the height of its parent container, so that it should fit according to the design
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 137, 175, 76),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    // width: double.infinity / 2,
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  //this consist of the done Icon
                  Center(
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      elevation: 5,
                      child: CircleAvatar(
                        child: Icon(
                          Icons.done_rounded,
                          size: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                    ),
                  ),
                ],
              )),

          //container for amount
          Center(
            child: Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.currency_rupee_rounded, size: MediaQuery.of(context).size.width * 0.08,),
                  Text(
                    widget.addedAmount!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Container for added successfully text
          Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: const Center(
                  child: Text(
                'Added Successfully To Your Wallet',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ))),

          //Container for date and time text
          Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              child: Center(
                  child: Text(
                DateFormat('H:m, dd MMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey),
              ))),

          //Container for Wallet balance
          Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text(
                'Wallet Balance: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.055),
              ),
              Icon(Icons.currency_rupee_rounded, size: MediaQuery.of(context).size.width * 0.055,),
              walletAmount == null
                  ? const CircularProgressIndicator()
                  : Text(
                      walletAmount,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.055),
                    ),
                ],
              )),
        ],
      ),
    );
  }
}