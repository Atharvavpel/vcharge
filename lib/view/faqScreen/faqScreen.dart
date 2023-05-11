
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FaqScreen extends StatefulWidget {
  @override
  FaqScreenState createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {
  String selectedCategory = 'General';
  List<dynamic> faqs = [];

  Future<void> getFaqs() async {
    
    var response = await http.get(Uri.parse('http://192.168.0.41:8098/manageFaq/faqs'));

    if (response.statusCode == 200) {
      setState(() {
        faqs = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load FAQs');
    }
  }

  @override
  void initState() {
    super.initState();
    getFaqs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text("FAQ's"),
    centerTitle: true,
  ),
  body: Column(
    children: [
      Container(
        height: 60,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var category in ['General', 'Charger', 'Payment and refund', 'Troubleshooting and Maintenance'])
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: selectedCategory == category ? Colors.green : Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    child: Text(category),
                  ),
                ),
            ],
          ),
        ),
      ),
      Expanded(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: faqs.where((faq) => faq['faqCategory'] == selectedCategory).length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            var sortedFaqs = faqs.where((faq) => faq['faqCategory'] == selectedCategory).toList()
              ..sort((faq1, faq2) => int.parse(faq1['faqSeqNumber']).compareTo(int.parse(faq2['faqSeqNumber'])));
    
            var faq = sortedFaqs[index];
    
            return ExpansionTile(
              title: Text(faq['faqQuestion']),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(faq['faqAnswer']),
                ),
              ],
            );
          },
        ),
      ),
    ],
  ),
);



  }
}




/*



Scaffold(
      appBar: AppBar(
        title: const Text("FAQ's"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ToggleButtons(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Color.fromARGB(255, 199, 171, 29),
                      selectedColor: Colors.black,
                      
                      fillColor: Colors.green,
                      color: Colors.black,
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                        minWidth: 80.0,
                      ),
                  isSelected: ['General', 'Charger', 'Payment and refund', 'Application']
                      .map((category) => category == selectedCategory)
                      .toList(),
                  onPressed: (index) {
                    setState(() {
                      selectedCategory = ['General', 'Charger', 'Payment and refund', 'Application'][index];
                    });
                  },
                  children: ['General', 'Charger', 'Payment and refund', 'Application']
                      .map((category) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(category),
                      ),
                      
                      ).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: faqs.where((faq) => faq['faqCategory'] == selectedCategory).length,
              itemBuilder: (BuildContext context, int index) {
                var sortedFaqs = faqs.where((faq) => faq['faqCategory'] == selectedCategory).toList()
                  ..sort((faq1, faq2) => int.parse(faq1['faqSeqNumber']).compareTo(int.parse(faq2['faqSeqNumber'])));
    
                var faq = sortedFaqs[index];
    
                return ExpansionTile(
                  title: Text(faq['faqQuestion']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(faq['faqAnswer']),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );







*/