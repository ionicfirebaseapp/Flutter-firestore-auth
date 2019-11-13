import 'package:flutter/material.dart';
import 'package:auth_pro/styles/styles.dart';
import 'package:auth_pro/widgets/round-buttons.dart';
import 'package:auth_pro/widgets/gradient-bg.dart';
import 'package:auth_pro/screens/home/home.dart';
import 'package:auth_pro/screens/auth/sign-in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auth_pro/services/firestoreService.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    callFireStore();
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
  var errorText;

  bool loading = false;

  Firestore store;

  callFireStore() async {
    store = await fireStoreCommonService();
  }

  CollectionReference get users => store.collection('users');

  final databaseReference = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> registerUser() async {

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    } else {
      form.save();
      print('email name $email  $password');
//      await LoginService.registerUser(email, password, name).then((onValue) {
      FirebaseUser user = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userNew) {
        print('onvalue $userNew');
        setState(() {
          loading = false;
        });

//        userNew.sendEmailVerification().then((_) {
          showDialog<Null>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Container(
                width: 270.0,
                child: new AlertDialog(
                  title: new Text('Thank you for Signing Up with us...!!'),
                  content: new SingleChildScrollView(
                    child: new ListBody(
                      children: <Widget>[
                        new Text('Proceed with login'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text('ok'),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SignIn(),
                            ),
                                (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
              );
            },
          );

//        });
      }).catchError((onError) {
        setState(() {
          loading = false;
        });
        print('onnnnnn $onError');
        errorText = onError.toString().split(',')[1];
        showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Container(
              width: 270.0,
              child: new AlertDialog(
                title: new Text('Please check!!'),
                content: new SingleChildScrollView(
                  child: new ListBody(
                    children: <Widget>[
                      new Text('$errorText'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text('ok'),
                    onPressed: () {Navigator.pop(context);},
                  ),
                ],
              ),
            );
          },
        );
      });
    }
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
            child: TextFormField(
              style: subtitleWhiteTextAR(),
              cursorColor: Colors.white, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              keyboardType: TextInputType.emailAddress,
              onSaved: (String value) {
                 email = value;
              },
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Email Id';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Email Id",
                hintStyle: subtitleWhiteTextAR(),
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
            child: TextFormField(
              style: subtitleWhiteTextAR(),
              cursorColor: Colors.white, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              onSaved: (value) => password = value,
              validator: (String value) {
                if(value.length < 6)
                  return 'Password should be 6 or more digits';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Strong-Password99-here",
                hintStyle: subtitlePrimaryTextAR(),
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
            child: TextFormField(
              style: subtitleWhiteTextAR(),
              cursorColor: Colors.white, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
              onSaved: (value) => password2 = value,
              validator: (String value) {
                if(value.length < 6)
                  return 'Password should be 6 or more digits';
                else
                  return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0, right: 0.0, top: 10.0, bottom: 12.0),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none
                ),
                hintText: "Confirm Password",
                hintStyle: subtitleWhiteTextAR(),
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
                Form(
                  key: _formKey,
                  child: Container(
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
                ),
              ],
            ),
          )
      ),
    );
  }
}