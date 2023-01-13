import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  const CustomTab(
      {super.key,
      required this.title,
      this.backgroundColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return Tab(
        child: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Text(
          title,
          // textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ));
  }
}
