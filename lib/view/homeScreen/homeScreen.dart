import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/bgMap.dart';

import 'package:vcharge/view/homeScreen/widgets/bottomBar.dart';
import 'package:vcharge/view/homeScreen/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
  appBar: AppBar(
    
    backgroundColor: Colors.transparent,
    elevation: 0.0,    
  
      actions: [
        
        IconButton(onPressed: (){
  
        }, icon: const Icon(Icons.arrow_drop_down_circle), iconSize: 50, color: Colors.black),

        // const SizedBox(width: 10),
        Spacer(),

        Container(
              width: 200,
              height: 40,
              // color: Colors.grey,
              child: TextField(
                textAlign: TextAlign.center,
                
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                  hintText: 'Search Stations',
                  focusColor: Colors.red,
                  border: OutlineInputBorder( 
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                ),
                
              ),
            ),

        Spacer(),

      IconButton(onPressed: (){
  
        }, icon: const Icon(Icons.notifications_active), iconSize: 30, color: Colors.black),
        
  
  
      ]
      
        
  ),

      // drawer: AppDrawer(),
      body: Stack(children: [
        BgMap(),
      ]),

      // bottom navigation bar
      bottomNavigationBar: Container(
        
        child: CustomBottomAppBar(
          onTabSelected: _onItemTapped,
          selectedIndex: _selectedIndex,
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          // shape: ,
          splashColor: Colors.black,
          backgroundColor: Colors.green,
          
          onPressed: () {
            print("Onpressed on scanner");
          },
          child: const Icon(Icons.qr_code_scanner_sharp, size: 50,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
