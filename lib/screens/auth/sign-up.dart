import 'package:flutter/material.dart';
import 'package:auth/styles/styles.dart';
import 'package:auth/widgets/round-buttons.dart';
import 'package:auth/widgets/gradient-bg.dart';
import 'package:auth/screens/home/home.dart';
import 'package:auth/screens/auth/sign-in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool checkEmails = true;
  bool checkTerms = true;

  bool showText = true;

  FocusNode _focusNode, _focusNode2, _focusNode3;

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
    _focusNode2 = new FocusNode();
    _focusNode2.addListener(_onOnFocusNodeEvent);
    _focusNode3 = new FocusNode();
    _focusNode3.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  void showPassword() {
    setState(() {
      showText =! showText;
    });
  }

  String email;
  String password;
  String password2;

  Future<void> registerUser() async {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Widget emailForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Image.asset("lib/assets/icons/user.png", height: 16.0, width: 16.0,),
          Container(
            width: screenWidth(context)*0.7,
            child: TextField(
              style: subTitleWhiteTextAR(),
              cursorColor: Colors.white, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Email Id",
                hintStyle: subTitleWhiteTextAR(),
              ),
              focusNode: _focusNode,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNode.hasFocus ? BorderSide(color: Colors.white, style: BorderStyle.solid, width: 2.0) :
              BorderSide(color: Colors.white.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget passwordForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Image.asset("lib/assets/icons/lock.png", height: 16.0, width: 16.0,),
          Container(
            width: screenWidth(context)*0.72,
            child: TextField(
              style: subTitleWhiteTextAR(),
              cursorColor: Colors.white, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Strong-Password99-here",
                hintStyle: subTitlePrimaryTextAR(),
              ),
              focusNode: _focusNode2,
              obscureText: showText,
            ),
          ),
          InkWell(
              onTap: showPassword,
              child: showText ? Image.asset("lib/assets/icons/not-show.png", height: 16.0, width: 16.0,) :
              Image.asset("lib/assets/icons/show.png", height: 16.0, width: 16.0,)
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNode2.hasFocus ? BorderSide(color: Colors.white, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.white.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    Widget confirmPassword = Container(
      margin: EdgeInsets.only(top: 18.0),
      child: Row(
        children: <Widget>[
          Image.asset("lib/assets/icons/lock.png", height: 16.0, width: 16.0,),
          Container(
            width: screenWidth(context)*0.72,
            child: TextField(
              style: subTitleWhiteTextAR(),
              cursorColor: Colors.white, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              onChanged: (value) => password2 = value,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Confirm Password",
                hintStyle: subTitleWhiteTextAR(),
              ),
              focusNode: _focusNode3,
              obscureText: showText,
            ),
          ),
          InkWell(
              onTap: showPassword,
              child: showText ? Image.asset("lib/assets/icons/not-show.png", height: 16.0, width: 16.0,) :
              Image.asset("lib/assets/icons/show.png", height: 16.0, width: 16.0,)
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: _focusNode3.hasFocus ? BorderSide(color: Colors.white, style: BorderStyle.solid, width: 2.0) :
          BorderSide(color: Colors.white.withOpacity(0.7), style: BorderStyle.solid, width: 1.0),
        ),
      ),
    );

    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                GradientBg(),
                Container(
                  alignment: AlignmentDirectional.center,
                  margin: EdgeInsets.only(top: 80.0),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Sign Up", style: titleWhiteTextAB(),),
                      Container(
                        margin: EdgeInsets.only(top: 24.0,bottom: 30.0),
                        alignment: AlignmentDirectional.center,
                        width: screenWidth(context)*0.8,
                        child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy.",
                          style: textWhiteTextAR(), textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 4.0, right: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Email", style: textLightWhiteTextAR(),),
                            emailForm,
                            Text("Password", style: textLightWhiteTextAR(),),
                            passwordForm,
                            confirmPassword,
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            activeColor: primaryDark,
                            value: checkEmails,
                            onChanged: (bool value) {
                              setState(() {
                                checkEmails = value;
                              });
                            },
                          ),
                          Text("Yes, I want to receive promotional emails", style: textWhiteTextSR(),),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Checkbox(
                            activeColor: primaryDark,
                            value: checkTerms,
                            onChanged: (bool value) {
                              setState(() {
                                checkTerms = value;
                              });
                            },
                          ),
                          Container(
                            width: screenWidth(context)*0.74,
                            child: RichText(
                              text: new TextSpan(
                                style: textWhiteTextSR(),
                                children: <TextSpan>[
                                  new TextSpan(text: 'I agree with the'),
                                  new TextSpan(text: ' Terms and Condition ', style: textPrimaryTextSR()),
                                  new TextSpan(text: 'and the'),
                                  new TextSpan(text: ' Privacy Policy ', style: textPrimaryTextSR()),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0, bottom: 12.0),
                        child: RawMaterialButton(
                          onPressed: () async {
                            await registerUser();
                          },
                          child: RoundButton(title: "SIGN UP", color1: primaryDark, color2: primaryLight,),
                        ),
                      ),
                      RawMaterialButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text("Already have an account? ", style: textWhiteTextSR(),),
                              Text("Sign in here", style: textPrimaryTextSR(),)
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}