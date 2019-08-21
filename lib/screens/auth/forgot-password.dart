import 'package:flutter/material.dart';
import 'package:auth/styles/styles.dart';
import 'package:auth/widgets/round-buttons.dart';
import 'package:auth/screens/auth/otp-verify.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  FocusNode _focusNode;

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  Color _getBorderColor() {
    return _focusNode.hasFocus ? primaryDark : border;
  }

  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: primary,
        elevation: 0.0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Image.asset(
                    "lib/assets/imgs/curve-bg.png",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: screenHeight(context)*0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image.asset("lib/assets/imgs/key.png"),
                        Text("Forgot password ?", style: subtitleWhiteTextAB(),),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 18.0),
                width: screenWidth(context)*0.75,
                child: Column(
                  children: <Widget>[
                    Text("Enter The Email Address associated with your Account", style: subTitleDarkTextAB(), textAlign: TextAlign.center,),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 44.0),
                      child: Text("We will send you the linkto Reset your Password", style: titleDarkTextAR(), textAlign: TextAlign.center,),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 18.0),
                      width: screenWidth(context)*0.75,
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: subTitlePrimaryTextAR(),
                        cursorColor: primaryDark, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => email = value,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Enter Your Email",
                          hintStyle: titleDarkTextAR(),
                        ),
                        focusNode: _focusNode,
                      ),
                      decoration: new BoxDecoration(
                        border: new Border(
                          bottom: BorderSide(color: _getBorderColor(), style: BorderStyle.solid, width: 2.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              RawMaterialButton(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OtpVerify(),
                    ),
                  );
                },
                child: RoundButton(title: "SEND", color1: primaryDark, color2: primaryLight,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
