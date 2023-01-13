import 'package:flutter/material.dart';

class InfoScreens extends StatelessWidget {
  const InfoScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber,
        child: Center(child: Text('Infoskjermer')),
      ),
    );
  }
}
