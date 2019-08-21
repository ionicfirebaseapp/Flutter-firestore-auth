import 'package:flutter/material.dart';
import 'package:auth/styles/styles.dart';

class GradientBg extends StatefulWidget {
  @override
  _GradientBgState createState() => _GradientBgState();
}

class _GradientBgState extends State<GradientBg> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          image: AssetImage("lib/assets/bgs/bg-signup.png"),
          fit: BoxFit.cover,
          height: screenHeight(context),
          width: screenWidth(context),
        ),
        Container(
          height: screenHeight(context),
          width: screenWidth(context),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              image: AssetImage("lib/assets/bgs/bg-gradient.png"),
            ),
          ),
        ),
      ],
    );
  }
}
