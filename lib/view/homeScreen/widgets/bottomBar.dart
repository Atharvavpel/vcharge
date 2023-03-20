import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


class BottomAppBar extends StatelessWidget {
  const BottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
    backgroundColor: Colors.grey,
    animationDuration: const Duration(milliseconds: 300),
    items: const <Widget>[
      
      Icon(Icons.home, size: 30),
      Icon(Icons.qr_code_scanner, size: 30),
      Icon(Icons.list, size: 30),
      Icon(Icons.filter_alt_sharp, size: 30),
    ],
    
    );
  }
}