import 'package:flutter/widgets.dart';

// This is my extremely poor attempt to making this app responsive...

/*
  Dimensions
  VERSION: 1
  DATE EDITED: 04/15/2020
  EDITOR: Nikola Hack

  This file contains the dimensions (dim) of the app. Any change here should
  be directly visible in the corresponding Widgets. All dim's have been described
  as class-variables and get defined in the init-method.
  This modular structure makes the App-styling easier.

  */


class Dimensions {

  double width;
  double height;

  // Horizontal Spaces
  double hSmallSpace = 10;
  double hMidSpace = 15;
  double hBigSpace = 30;
  double hGiantSpace = 100;

  double textNewline = 7;

  // Vertical Spaces
  double vSmallSpace = 8;
  double vMidSpace = 15;
  double vBigSpace = 30;
  double vGiantSpace = 100;

  double iconTextSpace;

  double pictureSmall;
  double pictureMid;
  double pictureBig;

  // Circular Radius
  double smallRadius;
  double midRadius;
  double bigRadius;

  Dimensions(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    init();
  }

  init() {
    // Vertical
    iconTextSpace = 5;
    pictureMid = width/4;

    // Circular
    smallRadius = 8;
    midRadius = 15;
    bigRadius = 30;
  }

  // 1. Vertical Spaces

  SizedBox vSmall() {
    return SizedBox(height: 15);
  }
  SizedBox vMid() {
    return SizedBox(height: 40);
  }
  SizedBox vBig() {
    return SizedBox(height: height/15);
  }
  SizedBox vGiant() {
    return SizedBox(height: 150);
  }

  SizedBox newLine() {
    return SizedBox(height: textNewline);
  }


  // 2. Horizontal Spaces

  SizedBox hTiny() {
    return SizedBox(width: 2);
  }
  SizedBox hSmall() {
    return SizedBox(width: 10);
  }
  SizedBox hMid() {
    return SizedBox(width: 15);
  }
  SizedBox hBig() {
    return SizedBox(width: 30);
  }
  SizedBox hGiant() {
    return SizedBox(width: 50);
  }

  SizedBox iconText() {
    return SizedBox(width: iconTextSpace);
  }
}