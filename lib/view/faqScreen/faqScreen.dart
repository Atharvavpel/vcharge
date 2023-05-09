/*

General
charger
refunds & payments
Application

*/


// import 'package:flutter/material.dart';

// class faqScreen extends StatefulWidget {
//   const faqScreen({super.key});

//   @override
//   State<faqScreen> createState() => faqScreenState();
// }

// class faqScreenState extends State<faqScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("FAQs"),
//         centerTitle: true,
//       ),
//       body: Container(
        
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:vcharge/services/GetMethod.dart';

class FAQWidget extends StatefulWidget {
  @override
  FAQWidgetState createState() => FAQWidgetState();
}

class FAQWidgetState extends State<FAQWidget> {

  Set<String> faqType = {};

  String firstType = "";
  String secondType = "";
  String thirdType = "";
  String fourthType = "";

  String faqQuestion = '';
  String faqAnswer = '';

  @override
  void initState() {
    getFaqDetails();
    super.initState();
  }

  String specificUrl = "http://192.168.0.243:8098/managefaq/faqs";

  Future<void> getFaqDetails() async {

    var response = await GetMethod.getRequest(specificUrl);
    for(int i=0;i<response.length;i++){
    faqType.add(response[i]['faqCategory']);
    }

    setState(() {
      firstType = faqType.elementAt(0);
    secondType = faqType.elementAt(1);
    thirdType = faqType.elementAt(2);
    // fourthType = faqType.elementAt(3);
    });

  }

  Future<void> faqByType(String type) async {

    var response = await GetMethod.getRequest(specificUrl);

    for(int i=0; i<response.length; i++){
      if(type == response[i]['faqType']){
        faqQuestion = response[i]['faqQuestion'];
        faqAnswer = response[i]['faqAnswer'];
        setState(() {
        
      });
      }
    }

  }


  int selectedIndex = 5;

  final buttonColors = [
    Colors.blueGrey[50],
    Colors.blueGrey[50],
    Colors.blueGrey[50],
    Colors.blueGrey[50],
  ];

  final buttonSelectedColors = [
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
  ];

  final buttonBorderRadius = BorderRadius.circular(20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("FAQ's"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            buildToggleButton(0, firstType),
                            buildToggleButton(1, secondType),
                            buildToggleButton(2, thirdType),
                            buildToggleButton(3, fourthType),
                          ],
                        ),
              ],
            ),
          ),
              selectedIndex == 0 ? ExpansionTile(
                title: Text(faqQuestion),
              ) : SizedBox(),
              selectedIndex == 1 ? ExpansionTile(
                title: Text(faqQuestion),
              ) : SizedBox(),
              selectedIndex == 2 ? ExpansionTile(
                title: Text(faqQuestion),
              ) : SizedBox(),
              selectedIndex == 3 ? ExpansionTile(
                title: Text(faqQuestion),
              ) : SizedBox(),

        ],
      ),
     
    );
  }

  Widget buildToggleButton(int index, String text) {
    return Container(
      decoration: BoxDecoration(
        color: selectedIndex == index
            ? buttonSelectedColors[index]
            : buttonColors[index],
        borderRadius: buttonBorderRadius,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
              faqByType(text);
            });
          },
          borderRadius: buttonBorderRadius,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              text,
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}



/*



*/