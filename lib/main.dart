import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auth/styles/styles.dart';
import 'package:auth/screens/home/first-screen.dart';

void main() async {
  runApp(new MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
//    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryDark,
        accentColor: primaryDark,
        cursorColor: Colors.black,
        backgroundColor: primaryDark,
        unselectedWidgetColor: Colors.grey,
      ),
      home: FirstScreen(),
    );
  }
}