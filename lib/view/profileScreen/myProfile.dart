import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcharge/models/userDetailsModel.dart';
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
  // String specificUserIdUrl = '';
  String specificUserIdUrl =
      "http://192.168.0.41:8081/manageUser/user?userId=USR20230405172425672";

  @override
  void initState() {
    super.initState();
    // specificUserIdUrl = "http://192.168.0.41:8081/manageUser/user?userId=${widget.userId}";
    getUserData();
  }

  String firstName = '';
  String lastName = '';
  String contactNo = '';
  String emailId = '';

  Future getUserData() async {
    var response = await GetMethod.getRequest(specificUserIdUrl);
    firstName = response['userFirstName'];
    lastName = response['userLastName'];
    contactNo = response['userContactNo'];
    emailId = response['userEmail'];
  }

  final ImagePicker picker = ImagePicker();
  XFile? selectedImage;

  Future getImage(ImageSource source) async {

    try{
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null)  return;
    // final imageTemporary = File(pickedFile.path);
    setState(() {
      selectedImage = pickedFile;
    });
  } catch(error) {
    print("error: $error");
  }
    // setState(() {
    //   selectedImage = pickedFile;
    // });
  }

  Widget bottomSheet(){
    print("inside the bottomsheet");
    return Container(
      height: MediaQuery.of(context).size.height* 0.20,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(400),
          topRight: Radius.circular(400)
        )
      ),
      child: Column(
        children: [
          const Text("Choose to import from"),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(onPressed: (){
                print("clicked upon the gallery option");
                getImage(ImageSource.gallery);
                print("Done with the gallery option");
                print("Exiting the bottomshett function");
              }, child: const Icon(Icons.browse_gallery),),
              FloatingActionButton(onPressed: (){
                print("clicked upon the camera option");
                getImage(ImageSource.camera);
                print("Done with the camera option");
                print("Exiting the bottomshett function");
              }, child: const Icon(Icons.camera_alt_outlined),)
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // color: Colors.amber.shade50,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.3,
                  child: Stack(
                    children: [
                      greenIntroWidgetWithoutLogos(),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 8, right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const HomeScreen())));
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_sharp,
                                    color: Colors.green,
                                  )),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const SettingPage())));
                                  },
                                  icon: const Icon(
                                    Icons.settings,
                                    color: Colors.green,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                print("clicked on circle avtar");
                                showModalBottomSheet(
                                  context: context, 
                                  builder: ((builder) => bottomSheet())
                                );
                              },
                              child: selectedImage == null
                                  ? Container(
                                      width: 120,
                                      height: 120,
                                      margin: const EdgeInsets.only(bottom: 20),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffD6D6D6)),
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
                                              image: FileImage(
                                                  File(selectedImage!.path)),
                                              fit: BoxFit.fill),
                                          shape: BoxShape.circle,
                                          color: const Color(0xffD6D6D6)),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: MediaQuery.of(context).size.width * 0.37,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context, 
                                  builder: ((builder) => bottomSheet())
                                );
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child: Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Icon(
                                            Icons.edit,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.028,
                                            color: Colors.white,
                                          ))),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 23),
                  child: Form(
                    child: Column(
                      children: [
                        TextContainer('Name', Icons.person_outlined,
                            'Snehal Matke', (String? input) {}),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        TextContainer('Contact No', Icons.home_outlined,
                            '+91 9393939393', (String? input) {}),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        TextContainer('Email id', Icons.card_travel,
                            'snehal@gmail.com', (String? input) {}),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
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
                                      left: MediaQuery.of(context).size.height *
                                          0.02,
                                      top: MediaQuery.of(context).size.height *
                                          0.0047),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.currency_rupee_sharp),
                                      ),
                                      Text(
                                        "200",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const VerticalDivider()),
                      Expanded(
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
                                      left: MediaQuery.of(context).size.height *
                                          0.03,
                                      top: MediaQuery.of(context).size.height *
                                          0.0047),
                                  child: Row(
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.event),
                                      ),
                                      Text(
                                        "02",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: const VerticalDivider()),
                      Expanded(
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
                                      left: MediaQuery.of(context).size.height *
                                          0.02),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(Icons.person_2),
                                      ),
                                      Text(
                                        "02",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
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

  TextContainer(
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
}
