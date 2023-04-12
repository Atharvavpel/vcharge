import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/homeScreen/homeScreen.dart';
import 'package:vcharge/view/homeScreen/widgets/virtuosoLogo.dart';
import 'package:vcharge/view/settingScreen/settingPage.dart';

class MyProfilePage extends StatefulWidget {
  String userId;

  MyProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyProfilePage> createState() => MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
// variables for storing the REST API

  // String specificUserIdUrl = '';
  String specificUserIdUrl =
      "http://192.168.0.41:8081/manageUser/user?userId=USR20230405172425672";

  @override
  void initState() {
    super.initState();
    // specificUserIdUrl = "http://192.168.0.41:8081/manageUser/user?userId=${widget.userId}";
    getUserData();
  }

// variables for storing the only displaying user details
  String firstName = '';
  String lastName = '';
  String contactNo = '';
  String emailId = '';

// function for fetching the user data
  Future getUserData() async {
    var response = await GetMethod.getRequest(specificUserIdUrl);
    firstName = response['userFirstName'];
    lastName = response['userLastName'];
    contactNo = response['userContactNo'];
    emailId = response['userEmail'];
  }

// variable for picking the image from the gallery or camera
  final ImagePicker picker = ImagePicker();

// var for storing the selected image
  File? selectedImage;

// function for fetching the image from the device
  Future getImage(ImageSource source) async {
    try {
      // temp var used to store the image once picked
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile == null) return;
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    } catch (error) {
      print("error: $error");
    }
  }

// function which returns the bottomsheet image
  Widget bottomSheet() {
    print("inside the bottomsheet");
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Choose to import from",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Spacer(),

            // icons for camera and gallery
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // gallery icon
                FloatingActionButton(
                  onPressed: () {
                    print("clicked upon the gallery option");
                    getImage(ImageSource.gallery);
                    print("Done with the gallery option");
                    print("Exiting the bottomshett function");
                  },
                  child: const Icon(Icons.image),
                ),

                // camera icon
                FloatingActionButton(
                  onPressed: () {
                    print("clicked upon the camera option");
                    getImage(ImageSource.camera);
                    print("Done with the camera option");
                    print("Exiting the bottomshett function");
                  },
                  child: const Icon(Icons.camera_alt_outlined),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

// function for displaying the semicircle at the top
  Widget greenIntroWidgetWithoutLogos(
      {String title = "My Profile", String? subtitle}) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(400),
              bottomRight: Radius.circular(400))),
      height: Get.height * 0.2,
    );
  }

// function for displaying the sessions, referrals etc widget
  textContainer(
      String title, IconData iconData, String name, Function validator,
      {Function? onTap, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Container(
          width: Get.width,
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
            child: Text(name),
          ),
        )
      ],
    );
  }

// function for nav bar icons -> back button and settings button
  Widget rowContainingNavBarIcons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          // back button
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HomeScreen())));
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.green,
                )),
          ),

          // settings button
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SettingPage())));
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.green,
                )),
          ),
        ],
      ),
    );
  }

// function for the profile avtar
  Widget profileAvtarWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: () {
          print("clicked on circle avtar");
          showModalBottomSheet(
              context: context, builder: ((builder) => bottomSheet()));
        },
        child: selectedImage == null
            ? Container(
                width: 120,
                height: 120,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffD6D6D6)),
                child: const Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                width: 120,
                height: 120,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(selectedImage!.path)),
                        fit: BoxFit.fill),
                    shape: BoxShape.circle,
                    color: const Color(0xffD6D6D6)),
              ),
      ),
    );
  }

// function for overlaying the edit icon over the profile avtar
  Widget editIconOverProfileAvtar() {
    return Positioned(
      bottom: 10,
      right: MediaQuery.of(context).size.width * 0.37,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context, builder: ((builder) => bottomSheet()));
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Icon(
                      Icons.edit,
                      size: MediaQuery.of(context).size.height * 0.028,
                      color: Colors.white,
                    ))),
          ),
        ),
      ),
    );
  }

// function for displaying user details
  Widget displayUserDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Form(
        child: Column(
          children: [
            textContainer('Name', Icons.person_outlined, 'Snehal Matke',
                (String? input) {}),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            textContainer('Contact No', Icons.home_outlined, '+91 9393939393',
                (String? input) {}),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            textContainer('Email id', Icons.card_travel, 'snehal@gmail.com',
                (String? input) {}),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }

// function for savings portal
  Widget userSavingsPortal() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            bottomLeft: Radius.circular(16.0),
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Column(
            children: [
              const Text(
                "Savings",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02,
                    top: MediaQuery.of(context).size.height * 0.0047),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.currency_rupee_sharp),
                    ),
                    Text(
                      "200",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// function for sessions portal
  Widget userSessionsPortal() {
    return Expanded(
      child: Container(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Column(
            children: [
              const Text(
                "Sessions",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.03,
                    top: MediaQuery.of(context).size.height * 0.0047),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.event),
                    ),
                    Text(
                      "02",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// function for referrals portal
  Widget userReferralsPortal() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Column(
            children: [
              const Text(
                "Referrals",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.02),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.person_2),
                    ),
                    Text(
                      "02",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.3,

// main elements starts:
                  child: Stack(
                    children: [
// semicircle container
                      greenIntroWidgetWithoutLogos(),

// icons container
                      rowContainingNavBarIcons(),
                      Stack(
                        children: [
                          // profile avtar widget
                          profileAvtarWidget(),

                          // edit button over the profie avtar
                          editIconOverProfileAvtar(),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                // display user details
                displayUserDetails(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                // container for sessions, referrals, savings
                IntrinsicHeight(
                  child: Row(
                    children: [
                      // savings portal
                      userSavingsPortal(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const VerticalDivider()),

                      // sessions portal
                      userSessionsPortal(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const VerticalDivider()),
                      userReferralsPortal(),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),

                // logo section
                Center(
                  child: Container(
                    child: const VirtuosoLogo(),
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
