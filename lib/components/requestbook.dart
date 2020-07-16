import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snotes/constants/const.dart';


class RequestBook extends StatefulWidget {
  @override
  _RequestBookState createState() => _RequestBookState();
}

class _RequestBookState extends State<RequestBook> {

  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);



  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _subTextController = TextEditingController();
  final TextEditingController _nameTextController=TextEditingController();
  final TextEditingController _authorTextController=TextEditingController();
  final TextEditingController _semTextController=TextEditingController();
  final TextEditingController _branchTextController=TextEditingController();

  Map<String,dynamic> notes;
  final DatabaseReference databaseReference=FirebaseDatabase.instance.reference().child("notesrequest");


  addRequest(){

    notes={
      "name":_nameTextController.text,
      "email":_emailTextController.text,
      "subject":_subTextController.text,
      "semester":_semTextController.text,
      "branch":_branchTextController.text,
      "author":_authorTextController.text,
    };

    databaseReference.push().set(notes).whenComplete((){
      Fluttertoast.showToast(msg: "Request submitted successfully.Thanks!");
    });
  }

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
                'Request a note from the mentors',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 28),
              ),
              SizedBox(height: 20),
              Text(
                'Enter the required details below .',
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
              ),
              SizedBox(
                height: 50,
              ),
//              _buildTextEmailField(
//                  nameController, Icons.account_circle, 'Username'),
              Form(

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
                            labelText:"E-mail",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                            fillColor: secondaryColor,
                            isDense: true,
                            border: InputBorder.none,
                            filled: true,

                          ),

                          keyboardType: TextInputType.emailAddress,
                          controller: _emailTextController,

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

                            labelText: "Subject",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                            fillColor: secondaryColor,
                            isDense: true,
                            border: InputBorder.none,

                          ),

                          keyboardType: TextInputType.text,
                          controller: _subTextController,

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

                            //icon: Icon(Icons.lock_outline,size: 25,color: Colors.white,),
                            labelText: "Semester",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                            fillColor: secondaryColor,
                            isDense: true,
                            border: InputBorder.none,

                          ),

                          keyboardType: TextInputType.text,
                          controller: _semTextController,

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

                            //icon: Icon(Icons.lock_outline,size: 25,color: Colors.white,),
                            labelText: "What is your branch?",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                            fillColor: secondaryColor,
                            isDense: true,
                            border: InputBorder.none,

                          ),

                          keyboardType: TextInputType.text,
                          controller: _branchTextController,

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

                            //icon: Icon(Icons.lock_outline,size: 25,color: Colors.white,),
                            labelText: "Whose notes would you prefer?",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 16),
                            fillColor: secondaryColor,
                            isDense: true,
                            border: InputBorder.none,

                          ),

                          keyboardType: TextInputType.text,
                          controller: _authorTextController,

                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 20),
              SizedBox(height: 30),
              MaterialButton(
                elevation: 0,
                minWidth: double.maxFinite,
                height: 50,
                onPressed: () {
                addRequest();
                },
                color: logoGreen,
                child: Text('Submit!',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                textColor: Colors.white,
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

