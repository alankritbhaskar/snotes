import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
        Subjects(
          image_location: 'images/subjects/comp.png',
          image_caption: 'CSE',
        ),
          Subjects(
            image_location: 'images/subjects/electro.png',
            image_caption: 'ECE',
          ),
          Subjects(
            image_location: 'images/subjects/math.png',
            image_caption: 'Maths',
          ),
          Subjects(
            image_location: 'images/subjects/elect.png',
            image_caption: 'EEE',
          ),
          Subjects(
            image_location: 'images/subjects/mech.png',
            image_caption: 'ME',
          ),
          Subjects(
            image_location: 'images/subjects/phy.png',
            image_caption: 'Physics',
          ),
          Subjects(
            image_location: 'images/subjects/pie.png',
            image_caption: 'PIE',
          ),
          Subjects(
            image_location: 'images/subjects/meta.png',
            image_caption: 'MME',
          ),
          Subjects(
            image_location: 'images/subjects/civ.png',
            image_caption: 'CE',
          ),
        ],
      ),
    );
  }
}

class Subjects extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Subjects({
    this.image_location,
    this.image_caption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap:(){},
        child: Container(

          width: 100,

          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom:5.0),
              child: Image.asset(image_location,
              height: 45,
              width: 85,),
            ),

            subtitle: Text(image_caption, textAlign: TextAlign.center,),
      ),
        ),
      ),
    );
  }
}
