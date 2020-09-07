import 'package:flutter/material.dart';
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

class AppDimensions {

  double width;
  double height;

  // Horizontal Spaces
  double hSmallSpace;
  double hMidSpace;
  double hBigSpace;
  double hGiantSpace;

  double textNewline;

  double cardHeight;

  // Vertical Spaces
  double vSmallSpace;
  double vMidSpace;
  double vBigSpace;
  double vGiantSpace;

  double iconTextSpace;

  double pictureSmall;
  double pictureMid;
  double pictureBig;

  // Circular Radius
  double smallRadius;
  double midRadius;
  double bigRadius;

  AppDimensions(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    init();
  }

  init() {

    // Vertical
    cardHeight = height/2.8;
    vBigSpace = height/10;
    vGiantSpace = vBigSpace * 3;

    // Horizontal
    iconTextSpace = 5;
    pictureMid = width/4;
    pictureSmall = width/8;

    textNewline = 8;

    hSmallSpace = width/16;
    hMidSpace = width/8;

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
    return SizedBox(width: hSmallSpace/2);
  }
  SizedBox hSmall() {
    return SizedBox(width: hSmallSpace);
  }
  SizedBox hMid() {
    return SizedBox(width: hMidSpace);
  }
  SizedBox hBig() {
    return SizedBox(width: hMidSpace*2);
  }
  SizedBox hGiant() {
    return SizedBox(width: hBigSpace*1.5);
  }

  SizedBox iconText() {
    return SizedBox(width: iconTextSpace);
  }

  List<double> getFontSizes() {
    return [20,20,];
  }
}