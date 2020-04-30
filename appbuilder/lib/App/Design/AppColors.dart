import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {

  /*
  Corporate Colors
  VERSION: 1
  DATE EDITED: 04/05/2020
  EDITOR: Nikola Hack

  This file contains the color-information of the app. Any change here should
  be directly visible in the corresponding Views. All colors have been described
  as class-variables and got specialized for each module in the constructor.
  This modular structure makes the App-styling failsafe and dark-mode ready.

  Take a look into Coporate Branding Colors for more info on Colors.

  !IMPORTANT NOTE: Also take a look into main.dart for material Colors since
  those are still being used over the app and especially for tests regarding new
  Material Widgets.

  */

  // Backgrounds
  Color standardBackground;
  Color darkBackground;
  Color primary;
  Color secondary;
  Color tertiary;
  Color alternate;
  Color grad1;
  Color grad2;

  // 2. Text-colors
  Color text;
  Color textDark;
  Color textAtt;
  Color textApp;
  Color textOff;

  // 3. Icon-colors
  Color iconPrim;
  Color iconSec;
  Color iconAtt;
  Color iconApp;

  // 4. Material-colors
  // Circular Progress Indicator
  Color circPrT;
  Color circPrI;
  Color circPrI2;
  // Card
  Color cardBck;
  Color cardInk;
  Color cardInkP;   // Premium-User
  // Divider
  Color divider;

  // 5. Special Widget-colors
  Color dotAc;      // Dot-Indicator
  Color dotIn;      // Other Dots

  // 6. PopUp-colors
  Color popBack;    // Background
  Color popText;    // Text
  Color popTextIn;  // Text inactive
  Color popButton;  // Buttons
  Color popIcon;    // Icons

  // Customizing the Colors for each Module

  AppColors(int module) {

    // 1. Matching
    if (module == 1) {
    }

    // 2. Map
    else if (module == 2) {
    }

    // 3. Event
    else if (module == 3) {
    }

    // 4. Contacts
    else if (module == 4) {
    }

    // 5. Profile
    else if (module == 5) {


    } else {
      if (module != 0)
        print('CorporateColors Error: module $module not found');
      prime();
    }

  }

  prime() {
    standardBackground = Color(0xFFfdfffc);
    primary = Color(0xFF4f359b);
    secondary = Color(0xFF4f7ca4);
    tertiary = Color(0xFF16425b);
    alternate = Color(0xFFa31621);
    darkBackground = Color(0xFF333333);

    standard();
  }

  standard() {
    grad1 = Colors.white;
    grad2 = primary.withAlpha(10);

    // 2. Text-colors
    text = Colors.black;
    textDark = Colors.white;
    textAtt = primary;
    textApp = Colors.lightGreen;
    textOff = Colors.black54;

    // 3. Icon-colors
    iconPrim = primary;
    iconSec = Colors.black54;
    iconAtt = Colors.redAccent;
    iconApp = Colors.lightGreen;

    // 4. Material-colors
    // Circular Progress Indicator
    circPrT = Colors.black;
    circPrI = primary;
    circPrI2 = Colors.white38;
    // Card
    cardBck = Colors.white;
    cardInk = Colors.black12;
    cardInkP = primary.withAlpha(20);
    // Divider
    divider = Colors.black38;

    // 5. Special Widget-colors
    dotAc = primary;                // Dot-Indicator
    dotIn = secondary;  // Other Dots

    // 6. PopUp-colors
    popBack = darkBackground;       // Background
    popText = Colors.white;         // Text
    popTextIn = Colors.white54;     // Text inactive
    popButton = primary;            // Buttons
    popIcon = primary;              // Icons
  }
}