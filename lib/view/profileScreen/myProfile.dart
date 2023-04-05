import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/homeScreen.dart';
import 'package:vcharge/view/homeScreen/widgets/virtuosoLogo.dart';
import 'package:vcharge/view/profileScreen/profileAvtar.dart';
import 'package:vcharge/view/settingScreen/settingPage.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.2, 0.4),
              colors: [Color.fromARGB(255, 241, 227, 200), Color.fromARGB(255, 232, 237, 238), Color.fromARGB(255, 186, 225, 192)],
            ),
          ),
          child: Stack(
            children: [
        
        
            // Stack's First child: semicircle
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 152, 239, 148),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(400),
                          bottomRight: Radius.circular(400),
                        ))),
              ),
            
            // Stack's Second child: column
              Column(
                children: [
                  // Column's first child - buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // back arrow button
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 30, top: 10, left: 30),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_back_sharp,
                                color: Colors.green,
                              )),
                        ),
                      ),
            
                      // settings button
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SettingPage(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.settings_sharp,
                                color: Colors.green,
                              )),
                        ),
                      )
                    ],
                  ),
            
                  // Column's second child - circle avtar
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 188, 222, 189),
                      border:
                          Border.all(color: const Color.fromARGB(255, 148, 225, 41)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: ProfileAvatarWidget()
                    ),
                  ),
            
                  // Column's third child: name row
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 4),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Name:"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.57,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                    
                                  )
                                )
                              ),
                              child: const Center(child: Text("Mr. Sherlock Holmes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              )),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
            
                  // Column's fourth child: mobile no. row
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Mobile No:"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.57,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  )
                                )
                              ),
                              child: const Center(child: Text("+91 9393939393",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              )),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
            
                  // Column's fifth child: email id row
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Email ID:"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.57,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  )
                                )
                              ),
                              child: const Center(child: Text("sherlock@outlook.com",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              )),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
            
                  // Column's sixth child: simple container
        
                  // savings container
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Row(
                      children: [
                        Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Container(
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 247, 222, 185),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()                            
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                    children: [
                                      const Text("Savings", 
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.currency_rupee_sharp),
                                          ),
                                          Text("200")
                                        ],
                                      )
                                    ],
                                  )
                            ),
                          ),
                        ),
                      ),
        
                      // sessions container
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Container(
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 185, 217, 247),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()                            
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                    children: [
                                      const Text("Sessions", 
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.event_note),
                                          ),
                                          Text("02")
                                        ],
                                      )
                                    ],
                                  )
                            ),
                          ),
                        ),
                      ),
        
                      // referrals container
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Container(
                            decoration: BoxDecoration(
                              // color: const Color.fromARGB(255, 195, 247, 185),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()                            
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                    children: [
                                      const Text("Referrals", 
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(Icons.person_2),
                                          ),
                                          Text("02")
                                        ],
                                      )
                                    ],
                                  )
                            ),
                          ),
                        ),
                      ),
                      ],
                    ),
                  )
                      ],
                    ),
              
            // Stack's third child: logo widget
              Positioned(
                  bottom: 10,
                  left: MediaQuery.of(context).size.width * 0.34,
                  child: VirtuosoLogo())
            ],
          ),
        ),
      ),
    );
  }
}
