import 'package:flutter/material.dart';

class TicketHistoryScreen extends StatefulWidget {
  String userId;

  TicketHistoryScreen({super.key, required this.userId});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket History"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: const Text("Under development"),
        ),
      ),
    );
  }
}