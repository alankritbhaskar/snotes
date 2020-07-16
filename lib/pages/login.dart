import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:snotes/pages/check.dart';
import 'package:snotes/pages/register.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final _formKey=GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    //FirebaseUser user;
    setState(() {
      loading = true;
    });
   // preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    if (isLoggedin) {
      //user=await firebaseAuth.currentUser();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirstScreen()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleEmailSignIn() async{

  }
  Future handleSignIn() async {
    //FirebaseUser user;
   // preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection("users")
          .where("id", isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      // if the user doesn't exist in our collection, just create the new user in our collection
      if (documents.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .setData({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          "profilePicture": firebaseUser.photoUrl,
          "email": firebaseUser.email,
        });
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("profilePicture", firebaseUser.photoUrl);
        await preferences.setString("email", firebaseUser.email);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString(
            "profilePicture", documents[0]['profilePicture']);
        await preferences.setString("email", documents[0]['email']);
      }
      Fluttertoast.showToast(msg: "!!! Login Successful !!!");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => FirstScreen()));
    } else {
      Fluttertoast.showToast(msg: "!!! Login failed, Try Again !!!");
    }
  }

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            child: Image.asset(
              'images/logo.png',
              height: 80,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('sNotes',
              textAlign: TextAlign.center,
              style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

//  _buildTextEmailField(
//      TextEditingController controller, IconData icon, String labelText) {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//      decoration: BoxDecoration(
//          color: secondaryColor, border: Border.all(color: Colors.blue)),
//      child: TextFormField(
//        controller: controller,
//        validator: (value) {
//          if (value.isEmpty) {
//            Pattern pattern =
//                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//            RegExp regex = new RegExp(pattern);
//            if (!regex.hasMatch(value))
//              return 'Please make sure your email address is valid';
//            else
//              return null;
//          }
//        },
//        style: TextStyle(color: Colors.white),
//        decoration: InputDecoration(
//            contentPadding: EdgeInsets.symmetric(horizontal: 10),
//            labelText: labelText,
//            labelStyle: TextStyle(color: Colors.white),
//            icon: Icon(
//              icon,
//              color: Colors.white,
//            ),
//            // prefix: Icon(icon),
//            border: InputBorder.none),
//      ),
//    );
//  }
//
//  _buildTextPasswordField(
//      TextEditingController controller, IconData icon, String labelText) {
//    return Container(
//      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//      decoration: BoxDecoration(
//          color: secondaryColor, border: Border.all(color: Colors.blue)),
//      child: TextFormField(
//        controller: controller,
//        validator: (value) {
//          if (value.isEmpty) {
//            Pattern pattern =
//                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//            RegExp regex = new RegExp(pattern);
//            if (!regex.hasMatch(value))
//              return 'Please make sure your email address is valid';
//            else
//              return null;
//          }
//        },
//        style: TextStyle(color: Colors.white),
//        decoration: InputDecoration(
//            contentPadding: EdgeInsets.symmetric(horizontal: 10),
//            labelText: labelText,
//            labelStyle: TextStyle(color: Colors.white),
//            icon: Icon(
//              icon,
//              color: Colors.white,
//            ),
//            // prefix: Icon(icon),
//            border: InputBorder.none),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryColor,
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign in to sNotes',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 28),
              ),
              SizedBox(height: 20),
              Text(
                'Enter your email and password below to continue to sNotes and let the learning begin!',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                height: 50,
              ),
//              _buildTextEmailField(
//                  nameController, Icons.account_circle, 'Username'),
            Form(
                key: _formKey,
                child: Column(
              children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: secondaryColor, border: Border.all(color: Colors.blue)),
                    child: TextFormField(
                       style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(

                        icon: Icon(Icons.email,size: 25,color: Colors.white,),
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                        fillColor: secondaryColor,
                        isDense: true,
                        border: InputBorder.none,

                      ),

                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextController,
                    validator: (value) {
                      if (value.isEmpty) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(value))
                          return 'Please make sure your email address is valid';
                        else
                          return null;
                      }
                    },
                    ),
                  ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: secondaryColor, border: Border.all(color: Colors.blue)),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(

                      icon: Icon(Icons.lock_outline,size: 25,color: Colors.white,),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                      fillColor: secondaryColor,
                      isDense: true,
                      border: InputBorder.none,

                    ),

                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordTextController,
                    validator: (value) {
                      if (!value.isEmpty) {


                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern);
                        if (value.length<6)
                          return 'Your password must be 6 character long';
                        else
                          return null;
                      }
                    },
                  ),
                ),
              ],
            )),
              SizedBox(height: 20),
//              Form(
//                  //key: _formKey,
//                  child: Column(
//                    children: <Widget>[
//
//                    ],
//                  )),
//              _buildTextPasswordField(
//                  _passwordTextController, Icons.lock, 'Password'),
              SizedBox(height: 30),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {},
                color: logoGreen,
                child: Text('Login',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                textColor: Colors.white,
              ),
              SizedBox(height: 20),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                  handleSignIn();
                },
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.google),
                    SizedBox(width: 10),
                    Text('Sign-in using Google',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
                textColor: Colors.white,
              ),
              SizedBox(height: 10),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Divider(
                      thickness: 2,
                      color: Colors.white,
                    ),
                    Text('Dont have an account. Sign Up!',
                        style: TextStyle(color: Colors.red, fontSize: 14,fontStyle: FontStyle.italic,fontWeight: FontWeight.w700)),
                  ],
                ),

              ),
              SizedBox(height: 45),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildFooterLogo(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
