import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/services.dart';
import 'package:snotes/pages/check2.dart';
import 'package:snotes/subtasks/image_text.dart';
import 'package:snotes/components/horizontalListView.dart';
import 'package:snotes/components/books.dart';
import 'package:snotes/constants/const.dart';
import 'package:snotes/pages/login.dart';
import 'package:snotes/components/requestbook.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // bottom navigator pages navigation

  final tabs = [
    Center(
      child: Text('Explore'),
    ),
    Center(
      child: Text('Favourite'),
    ),
    Center(
      child: Text('My Downloads'),
    ),
    Center(
      child: Text('Request Note'),
    ),
    Center(
      child: Text('Account'),
    ),
  ];

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {

    Widget image_corousel = new Container(
        height: 200.0,
        child: Carousel(
          boxFit: BoxFit.cover,
          images: [
            ExactAssetImage("images/i1.jpg"),
            ExactAssetImage('images/i2.jpg'),
            ExactAssetImage('images/i3.jpg'),
            ExactAssetImage('images/i4.jpg'),
          ],
          showIndicator: true,
          borderRadius: false,
          autoplay: true,
          autoplayDuration: Duration(milliseconds: 4000),
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          moveIndicatorFromBottom: 10.0,
          dotSize: 6,
          indicatorBgPadding: 7.0,
          dotBgColor: Colors.black54.withOpacity(0.5),
          noRadiusForIndicator: true,
          overlayShadow: true,
          overlayShadowColors: Colors.white,
          overlayShadowSize: 0.3,
        ));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: primaryBlack,
        title: Text('sNotes'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageToText()));
              }),
          IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      drawer: Drawer(
        elevation: 15,
        child: ListView(
          //header of the drawer

          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('alan'),
              accountEmail: Text('alan@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  // backgroundImage: NetworkImage(
                  // imageUrl,
                  //),
                  radius: 60,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),

            // body of the drawer

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(
                  Icons.home,
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Buy Notes'),
                leading: Icon(
                  Icons.add_shopping_cart,
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Upload Notes'),
                leading: Icon(
                  Icons.file_upload,
                ),
              ),
            ),

            Divider(
              thickness: 0.5,
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Feedback'),
                leading: Icon(
                  Icons.feedback,
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.info,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }), ModalRoute.withName('/'));
              },
              child: ListTile(
                title: Text('Log Out'),
                leading: Icon(
                  Icons.power_settings_new,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          image_corousel,
          Padding(padding: const EdgeInsets.all(2)),

          Padding(
            padding: const EdgeInsets.only(bottom: 2.0, left: 10, top: 2),
            child: Row(
              children: <Widget>[
                Text(
                  'SUBJECTS',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          //Horizontal List here

          HorizontalList(),

          // Main book notes availability screen

          Padding(padding: const EdgeInsets.all(2)),

          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 10, top: 2),
            child: Row(
              children: <Widget>[
                Text(
                  'AVAILABLE NOTES',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ),

          Flexible(
            child: Books(),
          ),
        ],
      ),

      // bottom navigation bar


      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: primaryBlack,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(

            icon: Icon(
              Icons.library_books,
              color: Colors.white,
            ),
            backgroundColor: Colors.blueGrey,
            title: Text('Explore',
                style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            backgroundColor: Colors.blueGrey,
            title: Text('Favourite',
                style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
          BottomNavigationBarItem(

            icon: Icon(
              Icons.file_download,
              color: Colors.white,
            ),
            backgroundColor: Colors.blueGrey,
            title: Text('Downloads',
                style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),

            backgroundColor: Colors.blueGrey,
            title: InkWell(
              child: Text('Request Note',
                  style: TextStyle(color: Colors.white, fontSize: 11)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RequestBook()));
              },
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            backgroundColor: Colors.blueGrey,
            title: Text('Account',
                style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ],
        onTap: (index) {
          _currentIndex = index;
        },
      ),
    );
  }
}
