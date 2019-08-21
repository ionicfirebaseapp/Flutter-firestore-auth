import 'package:flutter/material.dart';
import 'package:auth/styles/styles.dart';
import 'package:auth/widgets/round-buttons.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:auth/screens/home/home.dart';

class OtpVerify extends StatefulWidget {
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {

  static final int _pinLength = 4;

  static final TextStyle _textStyle = titleBlackTextAB();

  PinEditingController _pinEditingController =
  PinEditingController(pinLength: _pinLength, autoDispose: false);

  PinDecoration _pinDecoration = UnderlineDecoration(
    textStyle: _textStyle,
    enteredColor: primaryDark,
    color: light,
    gapSpace: 18.0,
  );

  bool _enable = true;

  @override
  void initState() {
    _pinEditingController.addListener(() {
      debugPrint('changed pin:${_pinEditingController.text}');
    });
    super.initState();
  }

  @override
  void dispose() {
    _pinEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    otpTextForm() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 50,
              child: TextField(
                textAlign: TextAlign.center,
                style: titleBlackTextAB(),
                cursorColor: dark, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 16.0),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none
                  ),
                  hintText: "*",
                  hintStyle: TextStyle(color: light),
                  counterText: ""
                ),
                maxLength: 1,
              ),
            ),
            Container(
              height: 1.0, width: 50.0, color: light,
            ),
          ],
        ),
      );
    }

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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset("lib/assets/imgs/key.png"),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Text("Verification", style: subtitleWhiteTextAB(),),
                        ),
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
                    Text("OTP sent to your Email Address associated with your Account", style: subTitleDarkTextAB(), textAlign: TextAlign.center,),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 44.0),
                      child: Text("We will send you the linkto Reset your Password", style: titleDarkTextAR(), textAlign: TextAlign.center,),
                    ),
//                    Row(
//                      children: <Widget>[
//                        otpTextForm(),
//                        otpTextForm(),
//                        otpTextForm(),
//                        otpTextForm(),
//                      ],
//                    ),
                    PinInputTextField(
                      pinLength: _pinLength,
                      decoration: _pinDecoration,
                      pinEditingController: _pinEditingController,
                      autoFocus: true,
//                      textInputAction: TextInputAction.go,
                      enabled: _enable,
                      onSubmit: (pin) {
                        debugPrint('submit pin:$pin');
                      },
                    ),
                  ],
                ),
              ),
              RawMaterialButton(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
                child: RoundButton(title: "VERIFY", color1: primaryDark, color2: primaryLight,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
