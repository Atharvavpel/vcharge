import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/bookingModel.dart';
import 'cancelReservAlertPopUp.dart';
import 'cancellationDonePopUp.dart';

class CancelReservtionPopUp extends StatefulWidget {
  CancelReservtionPopUp({super.key});

  @override
  State<CancelReservtionPopUp> createState() => CancelReservtionPopUpState();
}

class CancelReservtionPopUpState extends State<CancelReservtionPopUp> {
  BookingModel? bookingModel;

  TextEditingController additionInfo = TextEditingController();

  var cancelReasonsList = [
    'Time Issue',
    'Change of Plans',
    'Technical Issue',
    'Other'
  ];

  var selectedReason;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        child: Wrap(children: [
          //"Booking Details" Heading text
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 113, 174, 76),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cancel Reservation',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Get.height * 0.025),
              ),
            )),
          ),
    
          //Select Reason heading
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select Reason',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Get.width * 0.05),
            ),
          ),
    
          //Select Reason dropDownMenu
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.height * 0.01),
            child: DropdownButtonFormField(
              hint: const Text('Select a Reason'),
              value: selectedReason,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              isExpanded: true,
              items: cancelReasonsList
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedReason = newValue!;
                });
              },
              validator: (value) {
                if(value == null){
                  return 'Please select a reason';
                }
              },
            ),
          ),
    
          //Addition info heading
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Additional Information',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Get.width * 0.05),
            ),
          ),
    
          // Addition info text field
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.05, vertical: Get.height * 0.01),
            child: TextFormField(
              maxLength: 150,
              maxLines: 5,
              keyboardType: TextInputType.streetAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              controller: additionInfo,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please give some additional info";
                }
                return null;
              },
            ),
          ),
    
          //Submit button
          Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.05, vertical: Get.height * 0.01),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    showDialog(
                      barrierDismissible: false,
                      context: context, 
                      builder: (context){
                      return CancellationDonePopUp();
                    });
                  }
                  else{
                    print('Un Successful');
                  }
                },
                child: const Text('Submit'),
              )),
        ]),
      ),
    );
  }
}
