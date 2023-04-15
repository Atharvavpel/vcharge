import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';

class SearchBarofLOS extends StatefulWidget {
  String userId;

  SearchBarofLOS({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => SearchBarofLOSState();
}

class SearchBarofLOSState extends State<SearchBarofLOS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(2, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.055),
        decoration: InputDecoration(
            border: InputBorder.none,
            label: const Text('Search Station'),
            prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search_rounded,
                  size: MediaQuery.of(context).size.width * 0.07,
                )),
            suffixIcon: IconButton(
                onPressed: () {
                  showDialog(context: context, builder: (BuildContext context) {
                    return FilterPopUp(userId: widget.userId);
                  });
                },
                icon: Icon(
                  Icons.filter_alt,
                  size: MediaQuery.of(context).size.width * 0.07,
                ))),
      ),
    );
  }
}
