
import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  final Function(int) onTabSelected;
  final int selectedIndex;

  CustomBottomAppBar({required this.onTabSelected, required this.selectedIndex});

  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(

        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.filter_alt_sharp),
                    color: Colors.green,
                    onPressed: () {
                      print("filter button pressed");
                  
                    },
                  ),
                  Container(
                    // margin: const EdgeInsets.only(top: 0),
                    child: const Text("Filter", style: TextStyle(fontWeight: FontWeight.bold))
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.view_list_sharp),
                    color: Colors.green,
                    onPressed: () {
                      print("list button pressed");
                  
                    },
                  ),
                  Container(
                    // margin: const EdgeInsets.only(top: 3),
                    child: const Text("Station List", style: TextStyle(fontWeight: FontWeight.bold))
                  )
                ],
              ),
            ),
          ],
        ),
      );
  }
}

class StationList extends StatelessWidget {
  final List<String> stations;


  StationList({required this.stations});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: stations.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(stations[index]),
          
        );
      },
    );
  }
}
