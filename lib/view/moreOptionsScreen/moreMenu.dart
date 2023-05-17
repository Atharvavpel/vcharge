import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MoreMenu extends StatelessWidget {
  const MoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SlidingUpPanel(
        backdropEnabled: true, //darken background if panel is open
        backdropOpacity: 0.2,
        color: Colors.transparent, //necessary if you have rounded corners for panel
        /// panel itself
        panel: Container(
          decoration: const BoxDecoration(
            // background color of panel
            color: Colors.redAccent,
            // rounded corners of panel
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0),),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 40, height: 3,
        decoration: const BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
              const Center(
                child: Text("This is the sliding Widget",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        /// header of panel while collapsed
        collapsed: Container(
          decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0),),
          ),
          child: Column(
            children: [
              Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 40, height: 3,
        decoration: const BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
              const Center(
                child: Text("This is the collapsed Widget",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        /// widget behind panel
      ),
    );
  }
}

