import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcharge/view/passwordScreen/widget/confirmationSuccessPopUp.dart';

class ChangePasswordScreen extends StatefulWidget {

  dynamic emailId;

  ChangePasswordScreen({super.key, required this.emailId});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

// variable for displaying the instructions 
  String? instruction = "Verify the email associated with your account and we'll send an email with instructions to reset your password" ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(Get.height* 0.02 ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              // Reset Password text
              Container(  
                margin: EdgeInsets.only(top: Get.height* 0.02),
                child: Text("Reset Password", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Get.height* 0.03
                ),),
              ),
      
      
              // instruction section
              Container(
                margin: EdgeInsets.only(top: Get.height* 0.01),
                child: Text('$instruction',
                  softWrap: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
      
              
              // Email Id
              Container(
                margin: EdgeInsets.only(top: Get.height* 0.01),
                child: const Text("Email Id")),
      
          // displaying email id
          Container(
            width: Get.width,
            margin: EdgeInsets.only(top: Get.height* 0.01),
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 1)
                ],
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
              child: Text(widget.emailId.toString()),
            ),
          ),
      
          // Send button
          Center(
            child: ElevatedButton(onPressed: (){
              print("the button is tapped");
                          // showBottomSheet(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return const ConfirmationSuccessPopUp();
                          //     });
              
            }, child: const Text("Send Instructions")),
          ),
            ],
      
          ),
        ),
      ),
    );
  }
}