
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  FaqScreenState createState() => FaqScreenState();
}

class FaqScreenState extends State<FaqScreen> {

  // variable for by default selecting the general property
  String selectedCategory = 'General';

  // list of dynamic data type for storing the FAQ's
  List<dynamic> faqs = [];

  // function for fetching up all the faqs and storing it in the FAQ list
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

  // initstate method which calls the getFaqs() method so that it can fetch all the faq's
  @override
  void initState() {
    super.initState();
    getFaqs();
  }

  // build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: const Text("FAQ's"),
    centerTitle: true,
  ),

  // column has two children: 
  body: Column(
    children: [

      // toggle buttons - first child
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
                      backgroundColor: selectedCategory == category ? Colors.green : Colors.grey,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    child: Text(category),
                  ),
                ),
            ],
          ),
        ),
      ),

      // questions and answers - second child
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: faqs.where((faq) => faq['faqCategory'] == selectedCategory).length,
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            // var sortedFaqs = faqs.where((faq) => faq['faqCategory'] == selectedCategory).toList()
            //   ..sort((faq1, faq2) => double.parse(faq1['faqSeqNumber']).compareTo(double.parse(faq2['faqSeqNumber'])));
            // ..sort((faq1, faq2) => int.parse(faq1['faqSeqNumber']).compareTo(int.parse(faq2['faqSeqNumber'])));

            var sortedFaqs;
            var faq;

            // block for sorting the specific category faq on the basis of the faq sequence number
           try {
             
             sortedFaqs = faqs.where((faq) => faq['faqCategory'] == selectedCategory).toList()
            ..sort((faq1, faq2) => faq1['faqSeqNumber'].compareTo(faq2['faqSeqNumber']));
            faq = sortedFaqs[index];

           } catch (e) {
             print("The error is in the faq: $e");
           }
  

    
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


