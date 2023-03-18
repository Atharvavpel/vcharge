import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';
import 'package:vcharge/view/listOfStations/listOfStations.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.filter_alt_sharp),
                    color: Colors.black,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FilterPopUp();
                          });
                    },
                  ),
                  Container(
                      // margin: const EdgeInsets.only(top: 0),
                      child: const Text("Filter",
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.view_list_sharp),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListOfStations()));
                    },
                  ),
                  Container(
                      // margin: const EdgeInsets.only(top: 3),
                      child: const Text("Station List",
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
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
