import 'package:flutter/material.dart';

import 'package:vcharge/view/homeScreen/widgets/BgMap.dart';

import 'package:vcharge/view/homeScreen/widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('vCharge'),
      ),
      drawer: const AppDrawer(),
      body: Container(
        child: Stack(
          children: [
            BgMap()
          ],
        ),
      ),
    );
  }
}
