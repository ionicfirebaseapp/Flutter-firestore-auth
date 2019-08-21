import 'package:flutter/material.dart';
import 'package:auth/styles/styles.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryDark,
        title: Text("Home", style: buttonWhiteTextSS(),),
      ),
    );
  }
}
