import 'package:flutter/material.dart';
import 'dart:async';
import 'package:quiz_app/screens/home_page.dart';
import 'package:quiz_app/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  //initState() is Called when this object is inserted into the tree.
//The framework will call this method exactly once for each [State] object it creates
  @override
  void initState() {
    super.initState();
    //replaces the screen with the HomePage screen after 2 seconds
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: deepPurpleColor,
      body: SafeArea(
        child: Center(
            child: Image.asset('images/quizlab_icon.jpg',
                height: 150.0, width: 150.0)),
      ),
    );
  }
}
