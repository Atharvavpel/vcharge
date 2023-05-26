import 'package:flutter/material.dart';
import 'package:vcharge/view/homeScreen/widgets/filterPopUp.dart';
import 'package:vcharge/view/listOfStations/widgets/losSearchingWidget.dart';


// ignore: must_be_immutable
class SearchBarofLOS extends StatefulWidget {
  String userId;

  SearchBarofLOS({required this.userId, super.key});

  @override
  State<StatefulWidget> createState() => SearchBarofLOSState();
}

class SearchBarofLOSState extends State<SearchBarofLOS> {


  @override
  Widget build(BuildContext context) {

    // material object - 
    return Scaffold(
      body: Container(
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
          readOnly: true,
    
          // function for opeing the searching widget
          onTap: (){
            showSearch(
                      context: context, 
                      delegate: losSearchingWidget(widget.userId)
                    );
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search Stations",
    
              // search icon - it also opens the searching widget
              prefixIcon: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context, 
                      delegate: losSearchingWidget(widget.userId)
                    );
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    size: MediaQuery.of(context).size.width * 0.07,
                  )),
    
              // filter icon - it is displayed at the right side
              suffixIcon: IconButton(
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return FilterPopUp(userId: widget.userId);
                      });
                  },
                  icon: Icon(
                    Icons.filter_alt,
                    size: MediaQuery.of(context).size.width * 0.07,
                  ))),
        ),
      ),
    );
  }
}
