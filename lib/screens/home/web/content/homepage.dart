import 'package:AirmineStudy/screens/home/homecontroller.dart';
import 'package:AirmineStudy/screens/home/web/content/contentTexts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WebLandingPage extends StatefulWidget {
  const WebLandingPage({
    super.key,
  });

  @override
  State<WebLandingPage> createState() => _WebLandingPageState();
}

class _WebLandingPageState extends State<WebLandingPage> {
  double screenHeight = 0;
  double screenWidth = 0;
  ScrollController scrollController = ScrollController();
  var homeWebcontroller = Get.put(HomeWebController());
  @override
  void initState() {
    scrollController.addListener(() {
      scrollListener();
    });
    super.initState();
  }

  void scrollListener() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    if (scrollController.position.pixels > screenHeight * 0.50) {
      homeWebcontroller.setBackGroundColor.value = true;
    } else {
      homeWebcontroller.setBackGroundColor.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 1.1,
            child: Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/family_on_field.jpg",
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: screenHeight * 0.65),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 180),
                          child: contentViHjelperDeg(screenWidth)),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.amber,
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.9,
                minHeight: 200,
              ),
              child: Center(child: Text('Placeholder')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.amber,
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.9,
                minHeight: 200,
              ),
              child: Center(child: Text('Placeholder')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.amber,
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.9,
                minHeight: 200,
              ),
              child: Center(child: Text('Placeholder')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.amber,
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.9,
                minHeight: 200,
              ),
              child: Center(child: Text('Placeholder')),
            ),
          ),
        ],
      ),
    );
  }
}
