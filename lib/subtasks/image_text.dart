import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class ImageToText extends StatefulWidget {
  @override
  _ImageToTextState createState() => _ImageToTextState();
}

class _ImageToTextState extends State<ImageToText> {
  File pickedImage;
  bool isImage = false;

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      pickedImage = tempStore;
      isImage = true;
    });
  }

  Future readText() async{
    FirebaseVisionImage myImage=FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recongnizeText=FirebaseVision.instance.textRecognizer();
    VisionText readText=await recongnizeText.processImage(myImage);

    for(TextBlock block in readText.blocks){
      for(TextLine line in block.lines){
        for(TextElement word in line.elements){
          print(word.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Column(
        children: <Widget>[
          isImage
              ? Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(pickedImage), fit: BoxFit.cover),
              ),
            ),
          )
              : Container(),
          RaisedButton(
            onPressed: pickImage,
            child: Text('Pick an Image'),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(child:
              Text('Read Text'),onPressed: readText),
        ],
      ),
    );
  }
}
