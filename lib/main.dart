import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/screens/splash_screen.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // //changes status color to transparent
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.green,
  //   ),
  // );
  //* Forcing only portrait orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData(
            primaryColor: Color(0xFF1D223A), primarySwatch: Colors.blue));
  }
}
