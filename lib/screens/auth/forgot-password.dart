import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import '../../screens/auth/sign-in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auth_pro/widgets/round-buttons.dart';

class ForgotPassword extends StatefulWidget {
  static String tag = "reset-password";
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();

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


  final databaseReference = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  String email;
  bool loading = false;

  resetPassword() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    } else {
      form.save();
      setState(() {
        loading = true;
      });
      if (email.isNotEmpty) {
        try{
          FirebaseUser user = await auth
              .sendPasswordResetEmail(email:email,)
              .then((userNew) {
            return null;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => SignIn(),
              ),
                  (Route<dynamic> route) => false);
        }catch(e){
          print('vvvvvvv $e');
        }
      }
      setState(() {
        loading = false;
      });
      return;
    }
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
            child: TextFormField(
              style: subtitlePrimaryTextAR(),
              cursorColor: primaryDark, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.emailAddress,
              onSaved: (String value) => email = value,
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Your Email Id';
                else
                  return null;
              },
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

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: _formKey,
          child: Container(
            alignment: AlignmentDirectional.center,
            margin: EdgeInsets.only(top: 50.0),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: <Widget>[
                Image.asset("lib/assets/imgs/centerLogo.png", width: 200.0, height: 180.0, fit: BoxFit.contain,),
                Container(
                  alignment: AlignmentDirectional.center,
                  padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                  child: Text("Forgot Password", style: titleBlackTextAB(),),
                ),
                Container(
                  alignment: AlignmentDirectional.center,
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text("Enter your Email Id, Reset password link will send to your email address",
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
                    ],
                  ),
                ),
                RawMaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  onPressed: () async {
                    await resetPassword();
                  },
                  child: RoundButton(title: "SIGN IN", color1: primaryDark, color2: primaryLight,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//Scaffold(
//resizeToAvoidBottomInset: false,
//body: GestureDetector(
//onTap: () {
//FocusScope.of(context).requestFocus(new FocusNode());
//},
//child: Stack(
//fit: StackFit.expand,
//children: <Widget>[
//new Image(
//image: new AssetImage("lib/assets/bg/image.png"),
//fit: BoxFit.cover,
//),
//Center(
//child: SingleChildScrollView(
//padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 30.0),
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.start,
//children: <Widget>[
//Image(
//image: AssetImage("lib/assets/icon/logo.png"),
//),
//Container(
//alignment: AlignmentDirectional.center,
//padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 30.0),
//child: Text(
//"Enter your Email Id, Reset password link will send to your email address",
////                        style: subTitleWhite2(),
//textAlign: TextAlign.center,
//),
//),
//Form(
//key: _formKey,
//child: Theme(
//data: ThemeData(
//brightness: Brightness.dark,
//accentColor: primary,
//inputDecorationTheme: new InputDecorationTheme(
//labelStyle: new TextStyle(
//color: primary,
//fontSize: 16.0,
//),
//),
//),
//child: Column(
//mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.center,
//children: <Widget>[
//Container(
//padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
//child: Stack(
//children: <Widget>[
//Container(
//width: screenWidth(context)*0.83,
//color: Colors.white,
//padding: EdgeInsets.only(left: 65.0),
//child: TextFormField(
//textAlign: TextAlign.left,
//cursorColor: border,
//decoration: InputDecoration(
//border: InputBorder.none,
//hintText: 'Email Id',
//hintStyle: hintStyleDark(),
//),
//style: hintStyleDark(),
//keyboardType: TextInputType.emailAddress,
//validator: (String value) {
//if (value.isEmpty ||
//!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//    .hasMatch(value)) {
//return 'Please enter a valid email';
//}
//},
//onSaved: (String value) {
//email = value;
//},
//),
//),
//Positioned(
//top: -6.0,
//right: (screenWidth(context) * 0.83) - 55.0,
//child: Stack(
//fit: StackFit.loose,
//alignment: AlignmentDirectional.center,
//children: <Widget>[
//Image.asset("lib/assets/icon/send.png"),
//Padding(
//padding: EdgeInsets.only(
//bottom: 8.0, left: 2.0),
//child: Icon(
//FontAwesomeIcons.user,
//color: Colors.white,
//size: 16.0,
//),
//),
//],
//),
//)
//],
//),
//),
//Padding(
//padding: EdgeInsetsDirectional.only(
//top: 30.0,
//start: 45.0,
//end: 45.0,
//bottom: 10.0),
//child: RawMaterialButton(
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.circular(5.0),
//),
//fillColor: secondary,
//child: Container(
//height: 45.0,
//width: screenWidth(context) * 0.5,
//decoration: BoxDecoration(
//borderRadius: BorderRadius.circular(5.0),
//),
//child: Row(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Text(
//'SUBMIT',
//style: subTitleWhiteSR(),
//),
//new Padding(
//padding: new EdgeInsets.only(
//left: 5.0, right: 5.0),
//),
//loading
//? new Image.asset(
//'lib/assets/gif/load.gif',
//width: 19.0,
//height: 19.0,
//)
//: new Text(''),
//],
//),
//),
//onPressed: resetPassword,
//splashColor: secondary,
//),
//),
//],
//),
//),
//)
//],
//),
//),
//),
//],
//),
//),
//);
