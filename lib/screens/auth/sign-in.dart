import 'package:flutter/material.dart';
import 'package:auth/styles/styles.dart';
import 'package:auth/widgets/round-buttons.dart';
import 'package:auth/screens/home/home.dart';
import 'package:auth/screens/auth/sign-up.dart';
import 'package:auth/screens/auth/forgot-password.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool checkRemember = true;
  bool showText = true;

  FocusNode _focusNode, _focusNode2;

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
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }

  Color _getBorderColor() {
    return _focusNode.hasFocus ? primaryDark : border;
  }

  Color _getBorderColor2() {
    return _focusNode2.hasFocus ? primaryDark : border;
  }

  void showPassword() {
    setState(() {
      showText =! showText;
    });
  }

  String email;
  String password;
  var errorText;

  Future<void> loginUser() async {
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
          Image.asset("lib/assets/icons/user-grey.png", height: 16.0, width: 16.0,),
          Container(
            width: screenWidth(context)*0.7,
            child: TextField(
              style: subTitlePrimaryTextAR(),
              cursorColor: primaryDark, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Email Id",
                hintStyle: subTitleBlackTextAR(),
              ),
              focusNode: _focusNode,
            ),
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: BorderSide(color: _getBorderColor(), style: BorderStyle.solid, width: 2.0),
        ),
      ),
    );

    Widget passwordForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Image.asset("lib/assets/icons/lock-grey.png", height: 16.0, width: 16.0,),
          Container(
            width: screenWidth(context)*0.72,
            child: TextField(
              style: subTitlePrimaryTextAR(),
              cursorColor: primaryDark, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Password",
                hintStyle: subTitleBlackTextAR(),
              ),
              focusNode: _focusNode2,
              obscureText: showText,
            ),
          ),
          InkWell(
            onTap: showPassword,
            child: showText ? Image.asset("lib/assets/icons/show-grey.png", height: 16.0, width: 16.0,) :
            Image.asset("lib/assets/icons/show.png", height: 16.0, width: 16.0,)
          ),
        ],
      ),
      decoration: new BoxDecoration(
        border: new Border(
          bottom: BorderSide(color: _getBorderColor2(), style: BorderStyle.solid, width: 2.0),
        ),
      ),
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          alignment: AlignmentDirectional.center,
//          padding: EdgeInsets.only(top: 50.0),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Image.asset("lib/assets/imgs/centerLogo.png", width: 200.0, height: 180.0, fit: BoxFit.contain,),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                child: Text("Sign In", style: titleBlackTextAB(),),
              ),
              Container(
                alignment: AlignmentDirectional.center,
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Remember to get up & stretch once in a while - your friends at chat.",
                  style: subTitleLightBlackTextAR(), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: EdgeInsets.only(left: 16.0, top: 28.0, bottom: 4.0, right: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Email", style: textLightBlackTextAR(),),
                    emailForm,
                    Text("Password", style: textLightBlackTextAR(),),
                    passwordForm,
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: primaryDark,
                        value: checkRemember,
                        onChanged: (bool value) {
                          setState(() {
                            checkRemember = value;
                          });
                        },
                      ),
                      Text("Remember me", style: textLightBlackTextAR(),),
                    ],
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                      );
                    },
                    child: Text("Forgot password?", style: textLightBlackTextAR(),),
                  )
                ],
              ),
              RawMaterialButton(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                onPressed: () async {
                  await loginUser();
                },
                child: RoundButton(title: "SIGN IN", color1: primaryDark, color2: primaryLight,),
              ),
              RawMaterialButton(
                onPressed: (){},
                child: Text("Or Login with", style: subTitleLightBlackTextAR(),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("lib/assets/icons/google-plus.png"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset("lib/assets/icons/twitter.png"),
                  ),
                  Image.asset("lib/assets/icons/facebook.png"),
                ],
              ),
              RawMaterialButton(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Dont't have an account? ", style: subTitleLightBlackTextAR(),),
                    Text("Sign up here", style: textPrimaryTextSR(),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
