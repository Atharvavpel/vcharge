import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<StatefulWidget> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Column(
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Hi, John Doe'),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text('Welcome'),
                ),

                //Container for available balance and others options
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Card(
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
                              Row(
                                children: const [
                                  Icon(Icons.currency_rupee_sharp),
                                  Text('${1000}')
                                ],
                              )
                            ],
                          ),

                          //Container for credit button
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5, // set the elevation value
                              ),
                              onPressed: () {},
                              child: const Text('Credit'),
                            ),
           
                        ],
                      ),
                    ),
                  ),
                )
              
                
              ],
            ),

        ],
      ),
    );
  }
}
