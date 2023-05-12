/*

----------------- SAMPLE REDIS CONNECTION CODE ------------------


// Client variable for redis connection
dynamic client;

// Command variable for redis connection
dynamic cmd;



Future<void> getUserData() async {
  client = RedisConnection();
  final response = await GetMethod.getRequest(specificUserIdUrl);

  profilePhoto = response['userProfilePhoto'];
  firstName = response['userFirstName'];
  lastName = response['userLastName'];
  contactNo = response['userContactNo'];
  emailId = response['userEmail'];


    cmd = await client.connect('192.168.0.136', 6379);
    await cmd.send_object(['SET','profilePhoto', profilePhoto]);
    await cmd.send_object(['SET','firstName', firstName]);
    await cmd.send_object(['SET','lastName', lastName]);
    client.close();
  setState(() {
    
  });
}







*/







import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcharge/services/GetMethod.dart';
import 'package:vcharge/view/homeScreen/widgets/virtuosoLogo.dart';
import 'package:vcharge/view/settingScreen/settingPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:redis/redis.dart' as redis;


// ignore: must_be_immutable
class MyProfilePage extends StatefulWidget {
  String? userId;

  MyProfilePage({super.key, required this.userId}) ;
  //: super(key: GlobalKey)

  @override
  State<StatefulWidget> createState() => MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {

  final GlobalKey<MyProfilePageState> globalKey = GlobalKey();

// variables for storing the REST API

  // String specificUserIdUrl = '';
  String specificUserIdUrl =
      "http://192.168.0.243:8097/manageUser/getUser?userId=USR20230420100343328";


// initstate function calling the getuserData method
  @override
  void initState() {
    super.initState();
    setState(() {
    });
    // specificUserIdUrl = "http://192.168.0.243:8097/manageUser/user?userId=${widget.userId}";
    getUserData();
  }


// variables for storing the only displaying user details
  String firstName = '';
  String lastName = '';
  String contactNo = '';
  String emailId = '';
  var profilePhoto = '';

// Client variable for redis connection
dynamic client;

// Command variable for redis connection
dynamic cmd;

Future<void> getUserData() async {

  client = redis.RedisConnection();
  dynamic response;
  
  try {
    response = await GetMethod.getRequest(specificUserIdUrl);
  
  profilePhoto = response['userProfilePhoto'];
  // print(profilePhoto);
  firstName = response['userFirstName'];
  lastName = response['userLastName'];
  contactNo = response['userContactNo'];
  emailId = response['userEmail'];

    cmd = await client.connect('192.168.0.206', 6379);


    await cmd.send_object(['SET','profilePhoto', profilePhoto]);
    await cmd.send_object(['SET','firstName', firstName]);
    await cmd.send_object(['SET','lastName', lastName]);
    await cmd.send_object(['SET','emailId', emailId]);
    await cmd.send_object(['SET','contactNo', contactNo]);
    client.close();
  } catch (e) {
    // print("the error at the redis connection in profile widget is: $e");
  }

  setState(() {
    
  });
}

void updateUserProfile(){
  setState(() {
    // print("inside the update profile function");
  });
}


// variable for picking the image from the gallery or camera
  final ImagePicker picker = ImagePicker();

// var for storing the selected image
  File? selectedImage;

// function for gallery and camera permissions
  Future<void> requestPermissions() async {
    // ignore: unused_local_variable
    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      Permission.storage,
    ].request();
    // print(statuses);
  }

// function for fetching the image from the device
  Future getImage(ImageSource source) async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus storageStatus = await Permission.storage.status;
    if (cameraStatus.isGranted && storageStatus.isGranted) {
      try {
        // temp var used to store the image once picked
        final pickedFile = await picker.pickImage(source: source);
        if (pickedFile == null) return;
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      } catch (error) {
        // print("error: $error");
      }
    } else {
      // The user has not granted the necessary permissions, show an error message.
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please grant the necessary permissions.')),
      );
    }
  }

// function which returns the bottomsheet image
  Widget bottomSheet() {
    // print("inside the bottomsheet");
    return SizedBox(
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
                    requestPermissions();
                    getImage(ImageSource.gallery);
                  },
                  child: const Icon(Icons.image),
                ),

                // camera icon
                FloatingActionButton(
                  onPressed: () {
                    requestPermissions();
                    getImage(ImageSource.camera);
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
          color: Color.fromARGB(255, 198, 235, 199),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      height: Get.height * 0.17,
    );
  }

// function for displaying the sessions, referrals etc widget
  Widget textContainer(
      String title, IconData iconData, dynamic name, Function validator,
      {Function? onTap, bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // displaying text
        Text(
          title,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),

        // displaying name
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
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back button
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
                          builder: ((context) =>
                              SettingPage(userId: widget.userId.toString(),
                              firstNameEdited: firstName,
                              lastNameEdited: lastName,
                              contactNoEdited: contactNo,
                              emailIdEdited: emailId,
                              ))));
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

    Widget widget;

    if(profilePhoto != null && profilePhoto.isNotEmpty){
      final profileImg = NetworkImage(profilePhoto);
    final decorationImg = DecorationImage(image: profileImg, fit: BoxFit.cover);

    widget = Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(


          // funtions for handling the edit profile photo widget
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => bottomSheet()));
            },
            child: profilePhoto == " "
                ? selectedImage == null
                    ? Container(
                        width: MediaQuery.of(context).size.width* 0.45,
                        height: MediaQuery.of(context).size.height* 0.2,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
                            shape: BoxShape.rectangle, color: Color(0xffD6D6D6)),
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width* 0.45,
                        height: MediaQuery.of(context).size.height* 0.2,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(selectedImage!.path)),
                                fit: BoxFit.cover),
                            shape: BoxShape.rectangle,
                            color: const Color(0xffD6D6D6)),
                      )
                : Container(
                    width: MediaQuery.of(context).size.width* 0.45,
                    height: MediaQuery.of(context).size.height* 0.2,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset:  Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                        image: decorationImg,
                        shape: BoxShape.rectangle,
                        color: const Color(0xffD6D6D6)),
                  )),
      ),
    );
    }
    else{
      // print("The profile photo is empty");
      widget = Container(
                        width: MediaQuery.of(context).size.width* 0.45,
                        height: MediaQuery.of(context).size.height* 0.2,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: const BoxDecoration(
        color: Colors.amber,
                            shape: BoxShape.rectangle, ),
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      );
    }

    return widget;

    // final profileImg = NetworkImage(profilePhoto);
    // final decorationImg = DecorationImage(image: profileImg, fit: BoxFit.cover);

    // return Padding(
    //   padding: const EdgeInsets.only(top: 20.0),
    //   child: Align(
    //     alignment: Alignment.bottomCenter,
    //     child: InkWell(


    //       // funtions for handling the edit profile photo widget
    //         onTap: () {
    //           showModalBottomSheet(
    //               context: context, builder: ((builder) => bottomSheet()));
    //         },
    //         child: profilePhoto == " "
    //             ? selectedImage == null
    //                 ? Container(
    //                     width: MediaQuery.of(context).size.width* 0.45,
    //                     height: MediaQuery.of(context).size.height* 0.2,
    //                     margin: const EdgeInsets.only(bottom: 20),
    //                     decoration: const BoxDecoration(
    //                         shape: BoxShape.rectangle, color: Color(0xffD6D6D6)),
    //                     child: const Center(
    //                       child: Icon(
    //                         Icons.camera_alt_outlined,
    //                         size: 40,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   )
    //                 : Container(
    //                     width: MediaQuery.of(context).size.width* 0.45,
    //                     height: MediaQuery.of(context).size.height* 0.2,
    //                     margin: const EdgeInsets.only(bottom: 20),
    //                     decoration: BoxDecoration(
    //                         image: DecorationImage(
    //                             image: FileImage(File(selectedImage!.path)),
    //                             fit: BoxFit.cover),
    //                         shape: BoxShape.rectangle,
    //                         color: const Color(0xffD6D6D6)),
    //                   )
    //             : Container(
    //                 width: MediaQuery.of(context).size.width* 0.45,
    //                 height: MediaQuery.of(context).size.height* 0.2,
    //                 margin: const EdgeInsets.only(bottom: 20),
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(20),
    //                     boxShadow: const [
    //                   BoxShadow(
    //                     color: Colors.grey,
    //                     offset:  Offset(
    //                       5.0,
    //                       5.0,
    //                     ),
    //                     blurRadius: 10.0,
    //                     spreadRadius: 2.0,
    //                   ), //BoxShadow
    //                   BoxShadow(
    //                     color: Colors.white,
    //                     offset: Offset(0.0, 0.0),
    //                     blurRadius: 0.0,
    //                     spreadRadius: 0.0,
    //                   ), //BoxShadow
    //                 ],
    //                     image: decorationImg,
    //                     shape: BoxShape.rectangle,
    //                     color: const Color(0xffD6D6D6)),
    //               )),
    //   ),
    // );
  }

// function for overlaying the edit icon over the profile avtar
  Widget editIconOverProfileAvtar() {
    return Positioned(
      bottom: 10,
      right: MediaQuery.of(context).size.width * 0.25,
      child: GestureDetector(

        // funtions for handling the edit profile photo widget
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

            // container for name
            textContainer('Name', Icons.person_outlined, " $firstName $lastName",
                (String? input) {}),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),

            // container for contact no
            textContainer('Contact No', Icons.home_outlined, contactNo,
                (String? input) {}),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            // container for email id
            textContainer('Email id', Icons.card_travel, emailId,
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
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
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: profileAvtarWidget(),
                        ),

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
    );
  }
}


