import 'package:flutter/material.dart';
import 'package:auth/styles/styles.dart';

class HalfRoundButton extends StatefulWidget {
  final title, color1, color2, left;
  HalfRoundButton({Key key, this.title, this.color1, this.color2, this.left}) : super(key: key);
  @override
  _HalfRoundButtonState createState() => _HalfRoundButtonState();
}

class _HalfRoundButtonState extends State<HalfRoundButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: 120.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: primaryDark,
        borderRadius: widget.left == "yes" ? BorderRadius.horizontal(left: Radius.circular(25),) :
        BorderRadius.horizontal(right: Radius.circular(25),),
        gradient: LinearGradient(
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          colors: <Color>[
            widget.color1,
            widget.color2,
          ],
        ),
        boxShadow: [BoxShadow(
          color: blueShadow,
          blurRadius: 10.0,
        ),],
      ),
      child: Text(widget.title, style: buttonWhiteTextSS(),),
    );
  }
}

class RoundButton extends StatefulWidget {
  final title, color1, color2;
  RoundButton({Key key, this.title, this.color1, this.color2}) : super(key: key);
  @override
  _RoundButtonState createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      width: 200.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: primaryDark,
        borderRadius: BorderRadius.horizontal(left: Radius.circular(25), right: Radius.circular(25)),
        gradient: LinearGradient(
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          colors: <Color>[
            widget.color1,
            widget.color2,
          ],
        ),
        boxShadow: [BoxShadow(
          color: blueShadow,
          blurRadius: 10.0,
        ),],
      ),
      child: Text(widget.title, style: buttonWhiteTextSS(),),
    );
  }
}
