
import 'package:flutter/material.dart';
import 'package:snotes/constants/const.dart';
import 'package:snotes/pages/splashscreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryBlack,
      ),
      home: SplashScreen(),
    );
  }
}

