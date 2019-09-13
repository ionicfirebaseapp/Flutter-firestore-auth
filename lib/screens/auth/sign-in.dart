import 'package:flutter/material.dart';
import 'package:auth_pro/styles/styles.dart';
import 'package:auth_pro/widgets/round-buttons.dart';
import 'package:auth_pro/screens/home/home.dart';
import 'package:auth_pro/screens/auth/sign-up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  bool loading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> loginUser() async {

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    } else {
      form.save();
      setState(() {
        loading = true;
      });
      try{
        FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Chat(
              user: user,
            ),
          ),
        );
      }catch(e){
        print('error........${e.toString()}');
        errorText = e.toString().split(',')[1];
        showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Container(
              width: 270.0,
              child: new AlertDialog(
                title: new Text('Please!!'),
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
      }
      setState(() {
        loading = false;
      });
      return;
    }
  }

  fbLoginUser(id, name, email,) async {
    var authData = {
      'facebookId': id,
      'name': name,
    };
    var data = json.encode(authData);
    print(json.encode(authData));
    print("facebook..............................$data");
  }

  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String message = 'Log in/out by pressing the buttons below.';
  bool fbLog = false;

  putData(accessToken, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    await fbLoginUser(accessToken.userId, data['name'], data['email'])
        .then((response) {
//      var resData = json.decode(response.body);
//      print('hhjjj  ${json.decode(response.body)}');
//      prefs.setString('token', resData['token']);
      // if (resData['response_code'] == 200) {
      print("data......................$data");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Chat(userData: data['name']),
          ),);
      // }
    });
    setState(() {
      loading = false;
    });
  }

  facebookLog(accessToken) async {
    await http
        .get(
        'https://graph.facebook.com/me?access_token=${accessToken.token}&fields=id,name,email,picture.type(large)')
        .then((res) {
      //	console.log('result ---' + JSON.stringify(res));
      //console.log('user image url==' + JSON.stringify(res.data.picture.data.url));
      String resp = res.body;
      var data = json.decode(resp);

      putData(accessToken, data);
      print('fb data---> $data');
    });
  }

  Future<Null> _facebookLogin() async {
    final FacebookLoginResult result = await facebookSignIn
        .logInWithReadPermissions(['public_profile, email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('token $accessToken');
        setState(() {
          fbLog = true;
        });
        await facebookLog(accessToken);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('cancel');
        await facebookSignIn.logOut();
        _showMessage('Logged out.');
        setState(() {
          fbLog = false;
        });
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('error');
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  void _showMessage(String message) {
    setState(() {
      message = message;
    });
  }

  static final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: '1OR06t702rtEEMGEDhe5Lfxpd',
    consumerSecret: 'vw7jKpy45DlE8Y0wpB5o886olhTgwsfFbLoRTmftWRGQ1qQwnT',
  );

  String _message = 'Logged out.';

  void _twitterLogin() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String newMessage;

    switch (result.status) {
      case TwitterLoginStatus.loggedIn:
        newMessage = 'Logged in! username: ${result.session.username}';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Chat(userData: result.session.username),
          ),);
        break;
      case TwitterLoginStatus.cancelledByUser:
        newMessage = 'Login cancelled by user.';
        break;
      case TwitterLoginStatus.error:
        newMessage = 'Login error: ${result.errorMessage}';
        break;
    }

    setState(() {
      _message = newMessage;
    });
  }



  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  Future<String> signInWithGoogle() async {

    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final FirebaseUser user = await _auth.signInWithCredential(credential);

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Chat(userData: user.email),
          ),);

      return 'signInWithGoogle succeeded: $user';


    } catch (error) {
      print('error............ $error');
    }

  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
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

    Widget passwordForm = Container(
      margin: EdgeInsets.only(bottom: 18.0),
      child: Row(
        children: <Widget>[
          Image.asset("lib/assets/icons/lock-grey.png", height: 16.0, width: 16.0,),
          Container(
            width: screenWidth(context)*0.72,
            child: TextFormField(
              style: subtitlePrimaryTextAR(),
              cursorColor: primaryDark, cursorRadius: Radius.circular(1.0), cursorWidth: 1.0,
                onSaved: (String value) => password = value,
              validator: (String value) {
                if(value.isEmpty)
                  return 'Please Enter Your Password';
                else
                  return null;
              },
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
                  child: Text("Sign Up", style: titleBlackTextAB(),),
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
                    InkWell(
                      onTap: signInWithGoogle,
                      child: Image.asset("lib/assets/icons/google-plus.png"),
                    ),
                    InkWell(
                      onTap: _twitterLogin,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.asset("lib/assets/icons/twitter.png"),
                      ),
                    ),
                    InkWell(
                      onTap: () => _facebookLogin(),
                      child: Image.asset("lib/assets/icons/facebook.png"),
                    ),
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
      ),
    );
  }
}
