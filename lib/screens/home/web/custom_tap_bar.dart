import 'package:flutter/material.dart';

class CustomTapBar extends StatelessWidget {
  const CustomTapBar({key, @required this.controller, @required this.tabs});
  final TabController controller;
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabBarScaling = screenWidth > 1400 ? 0.5 : 0.7;
    return Padding(
      padding: EdgeInsets.only(right: 0), // screenWidth * 0.05),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: screenWidth * tabBarScaling,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Theme(
                data: ThemeData(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.black12),
                child: TabBar(
                  splashBorderRadius: BorderRadius.circular(150),
                  indicatorColor: Colors.transparent,
                  controller: controller,
                  tabs: tabs,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
