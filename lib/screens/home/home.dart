import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auth_pro/styles/styles.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import '../auth/sign-in.dart';
import 'package:auth_pro/widgets/round-buttons.dart';

class Chat extends StatefulWidget {
  static const String id = "CHAT";
  final FirebaseUser user;
  final userData;

  const Chat({Key key, this.user, this.userData}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void signOutGoogle() async{
    await googleSignIn.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SignIn(),
        ),);

    print("User Sign Out");
  }

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: '1OR06t702rtEEMGEDhe5Lfxpd',
    consumerSecret: 'vw7jKpy45DlE8Y0wpB5o886olhTgwsfFbLoRTmftWRGQ1qQwnT',
  );

  String _message = 'Logged out.';

  void _twitterLogout() async {
    await twitterLogin.logOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SignIn(),
      ),);

    setState(() {
      _message = 'Logged out.';
    });
  }

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<Null> _facebookLogOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SignIn(),
      ),);
  }

  void _showMessage(String message) {
    setState(() {
      message = message;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SignIn(),
                ),);
            },
          )
        ],
      ),
      body: Container(
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
//            ClipOval(
//              child: Image.network("${widget.userData['picture']['data']['height']['url']}"),
//            ),
          Text("Welcome", style: textPrimaryTextSR(),),
        widget.user != null ? Text("${widget.user.email}", style: textPrimaryTextSR(),) :
            Text("${widget.userData}", style: textPrimaryTextSR(),),
//            Text("welcome ${widget.user.email}", style: textPrimaryTextSR(),),

            RawMaterialButton(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              onPressed: signOutGoogle,
              child: RoundButton(title: "Sign out from google", color1: primaryDark, color2: primaryLight,),
            ),
            RawMaterialButton(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              onPressed: _facebookLogOut,
              child: RoundButton(title: "Sign out from Facebook", color1: primaryDark, color2: primaryLight,),
            ),
            RawMaterialButton(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              onPressed: _twitterLogout,
              child: RoundButton(title: "Sign out from Twitter", color1: primaryDark, color2: primaryLight,),
            ),
          ],
        )
      )
    );
  }
}
