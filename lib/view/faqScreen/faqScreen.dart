// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:vcharge/models/faqModel.dart';
// import 'package:vcharge/services/GetMethod.dart';

// class FaqScreen extends StatefulWidget {
//   const FaqScreen({super.key});
  
//   @override
//   _FaqScreenState createState() => _FaqScreenState();
// }

// class _FaqScreenState extends State<FaqScreen> {
//   List<FaqModel> faqs = [];
//   String selectedType = "General";
//   bool isExpanded = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchFaqs();
//   }

//   Future<void> fetchFaqs() async {
//     var response =
//         await GetMethod.getRequest("http://192.168.0.46:5050/managefaq/faqs");
//     if (response.statusCode == 200) {
//       List<FaqModel> fetchedFaqs = [];
//       var faqsJson = jsonDecode(response.body);
//       faqsJson.forEach((faqJson) {
//         FaqModel faq = FaqModel.fromJson(faqJson);
//         fetchedFaqs.add(faq);
//       });
//       setState(() {
//         faqs = fetchedFaqs;
//         faqs.forEach((faq) => isExpanded = false);
//       });
//     }
//   }

//   List<FaqModel> getFaqsByType(String type) {
//     return faqs.where((faq) => faq.faqType == type).toList();
//   }

//   Widget buildQuestionAnswer(FaqModel faq) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("${faq.faqQuestion}"),
//         SizedBox(height: 8),
//         Text("${faq.faqAnswer}"),
//         Divider(),
//       ],
//     );
//   }

//   Widget buildExpandableList(String type) {
//     List<FaqModel> faqsByType = getFaqsByType(type);
//     return ExpansionPanelList(
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           faqsByType[index].isExpanded = !isExpanded;
//         });
//       },
//       children: faqsByType.map((faq) {
//         return ExpansionPanel(
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return ListTile(
//               title: Text("${faq.faqQuestion}"),
//             );
//           },
//           body: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: buildQuestionAnswer(faq),
//           ),
//           isExpanded: faq.isExpanded,
//         );
//       }).toList(),
//     );
//   }

//   Widget buildToggleButtons() {
//     List<String?> faqTypes = faqs.map((faq) => faq.faqType).toSet().toList();
//     faqTypes.sort(); // sorts the types alphabetically
//     return ToggleButtons(
//       isSelected: faqTypes.map((type) {
//         return type == selectedType;
//       }).toList(),
//       onPressed: (int index) {
//         setState(() {
//           selectedType = faqTypes[index]!;
//         });
//       },
//       children: faqTypes.map((type) {
//         return Text(type!);
//       }).toList(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("FAQs"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             buildToggleButtons(),
//             SizedBox(height: 16),
//             Expanded( // Add an Expanded widget here
//               child: buildExpandableList(selectedType),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
