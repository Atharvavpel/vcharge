import 'package:flutter/material.dart';

class ReservationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ReservationScreenState();
}

class ReservationScreenState extends State<ReservationScreen>{
  @override 
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Reservations'),
        ),
      ),
    );
  }
}