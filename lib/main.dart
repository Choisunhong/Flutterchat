import 'package:flutter/material.dart';
import 'package:teenchat/Screens/Homescreen.dart';


 void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext  context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "OpenSans",
        primaryColor: const Color(0xFF39E64F),
       
      ),
      home: Homescreen(),
    );
  }
}
