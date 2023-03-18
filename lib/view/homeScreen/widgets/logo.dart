import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class VirtuosoLogo extends StatelessWidget {
  const VirtuosoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 13, bottom: 10),
      width: 100,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: Image.asset("assets/images/logo.png"),
    );
  }
}
