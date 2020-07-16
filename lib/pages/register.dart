import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snotes/constants/const.dart';
import 'package:snotes/components/util.dart';
import 'package:snotes/pages/check1.dart';
import 'package:snotes/pages/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _nameTextController=TextEditingController();
  final TextEditingController _confirmPasswordController=TextEditingController();
  String gender="";
  final _formKey=GlobalKey<FormState>();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool loading=false;

  _buildFooterLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'images/logo.png',
            height: 80,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: primaryBlack,
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          //physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign Up to sNotes',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 28),
              ),
              SizedBox(height: 20),
              Text(
                'Enter the required details below to continue to sNotes and let the learning begin!',
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

                          //  icon: Icon(Icons.lock_outline,size: 25,color: Colors.white,),
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                            fillColor: secondaryColor,
                            isDense: true,
                            border: InputBorder.none,

                          ),

                          keyboardType: TextInputType.text,
                          controller: _nameTextController,
validator: (value){
                            if(value.isEmpty)
                              return "Name can't be empty";
                            else
                              return null;
},
//                          validator: (value) {
//                            if (!value.isEmpty) {
//
//
//                              Pattern pattern =
//                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                              RegExp regex = new RegExp(pattern);
//                              if (value.length<6)
//                                return 'Your password must be 6 character long';
//                              else
//                                return null;
//                            }
                         // },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: secondaryColor, border: Border.all(color: Colors.blue)),
                        child: TextFormField(
                           style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(

                            //icon: Icon(Icons.email,size: 25,color: Colors.white,),
                            labelText: "E-mail",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                            fillColor: secondaryColor,
                            isDense: true,
                            border: InputBorder.none,
                            filled: true,


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
                          obscureText: true,

                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(

                            //icon: Icon(Icons.lock_outline,size: 25,color: Colors.white,),
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
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            color: secondaryColor, border: Border.all(color: Colors.blue)),
                        child: TextFormField(
                          obscureText: true,

                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(

                            //icon: Icon(Icons.lock_outline,size: 25,color: Colors.white,),
                            labelText: "Confirm Password",
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
                child: Text('Submit and Sign Up!',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                textColor: Colors.white,
              ),
              SizedBox(height: 20),
//              MaterialButton(
//                elevation: 0,
//                minWidth: double.maxFinite,
//                height: 50,
//                onPressed: () {
//
//
//                  //handleSignIn();
//
//
//                },
//                color: Colors.blue,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//
//
//                    Icon(FontAwesomeIcons.google),
//                    SizedBox(width: 10),
//                    Text('Sign-in',
//                        style: TextStyle(color: Colors.white, fontSize: 16)),
//                  ],
//                ),
//                textColor: Colors.white,
//              ),
              //SizedBox(height: 10),
              FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Divider(
                      thickness: 2,
                      color: Colors.white,
                    ),
                    Text('Already have an account. Sign In!',
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

