import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {
  /*
  Corporate Colors
  VERSION: 1.2
  DATE LAST EDITED: 23/12/2020
  EDITOR: Nikola Hack

  This file contains the color-information of the app. Any change here should
  be directly visible in the corresponding Views. All colors have been described
  as class-variables and got specialized for each module in the constructor.
  This modular structure makes the App-styling failsafe and dark-mode ready.

  !IMPORTANT NOTE: Take a look into main.dart for material Colors since
  those are still being used over the app and especially for tests regarding new
  Material Widgets.

  */

  bool darkMode;

  // Backgrounds
  Color standardBackground;
  Color alternateBackground;
  Color primary;
  Color secondary;
  Color tertiary;
  Color alternate;
  Color grad1;
  Color grad2;

  // 2. Text-colors
  Color text;
  Color textAlternate;
  Color textAtt;
  Color textApp;
  Color textOff;

  // 3. Icon-colors
  Color icon;
  Color iconPrim;
  Color iconPrimOutline;
  Color iconSec;
  Color iconAtt;
  Color iconApp;

  // 4. Material-colors
  // Circular Progress Indicator
  Color circPrText;
  Color circPrIn;
  Color circPrIn2;

  // Card
  Color cardBck;
  Color cardInk;
  Color cardInkP; // Premium-User
  // Divider
  Color divider;

  // 5. Special Widget-colors
  Color dotAc; // Dot-Indicator
  Color dotIn; // Other Dots

  // 6. PopUp-colors
  Color popBack; // Background
  Color popText; // Text
  Color popTextIn; // Text inactive
  Color popButton; // Buttons
  Color popIcon; // Icons

  // Customizing the Colors for each Module

  AppColors(String design) {
    this.darkMode = false;
    initColors(design);
  }

  AppColors.dark(String design) {
    this.darkMode = true;
    initColors(design);
  }

  initColors(String design) {
    // Standard Theme
    if (design == 'orange' || design == 'standard' || design == '') {
      setColors(
        StandardBackground: darkMode ?  Color(0xFF333333) : Colors.white,
        Primary: Color(0xFFF98948),
        Secondary: Colors.amber,
        Tertiary: Color(0xFF9B8816),
        Alternate: Color(0xFF5D3A00),
        AlternateBackground: darkMode ? Colors.white : Color(0xFF333333),
      );
    }

    // 2. Theme
    else if (design == 'purple') {
      setColors(
        StandardBackground: darkMode ? Color(0xFF333333) : Colors.white,
        Primary: Colors.purple,
        Secondary: Colors.purpleAccent,
        Tertiary: Colors.deepPurpleAccent,
        Alternate: Colors.deepPurple,
        AlternateBackground: darkMode ? Colors.white : Color(0xFF333333),
      );
    }

    // 3. Theme
    else if (design == 'blue') {
    }

    // 4. Theme
    else if (design == 'green') {
    }

    // 5. Theme
    else if (design == 'module5') {

    } else if (design == 'coachniku') {
      setColors(
        StandardBackground: darkMode ? Color(0xFF111111) : Colors.white,
        Primary: Color(0xFFE36414),
        Secondary: Color(0xFF9A031E),
        Tertiary: Color(0xFF5F0F40),
        Alternate: Color(0xFF0F4C5C),
        AlternateBackground: darkMode ? Colors.white : Color(0xFF111111),
      );
    } else if (design == 'foostepz') {
      setColors(
        StandardBackground: darkMode ? Color(0xFF111111) : Colors.white,
        Primary: Color(0xFF3957FF),
        Secondary: Color(0xFF051b34),
        Tertiary: Color(0xFF5F0F40),
        Alternate: Color(0xFF0fdd47),
      );
    } else {
      print('CorporateColors: Warning - design ($design) not found - Proceeding with Standard-Design');
      design = 'standard';
      setColors(
        StandardBackground: darkMode ?  Color(0xFF333333) : Colors.white,
        Primary: Color(0xFFF98948),
        Secondary: Colors.amber,
        Tertiary: Color(0xFF9B8816),
        Alternate: Color(0xFF5D3A00),
        AlternateBackground: darkMode ? Colors.white : Color(0xFF333333),
      );
    }
    // Init the remaining colors.
    _standard();
  }

  setColors(
      {Color StandardBackground,
      Color Primary,
      Color Secondary,
      Color Tertiary,
      Color Alternate,
      Color AlternateBackground}) {
    standardBackground = StandardBackground;
    primary = Primary;
    secondary = Secondary;
    tertiary = Tertiary;
    alternate = Alternate;
    alternateBackground = AlternateBackground;
  }

  _standard() {
    grad1 = standardBackground;
    grad2 = darkMode ? primary : primary.withAlpha(10);

    // 2. Text-colors
    text = darkMode ? Colors.white : Colors.black;
    textAlternate = darkMode ? Colors.black : Colors.white;
    textAtt = primary;
    textApp = Colors.lightGreen;
    textOff = Colors.black54;

    // 3. Icon-colors
    iconPrim = primary;
    iconPrimOutline = iconPrim.computeLuminance() < 0.5 ? Colors.white : Colors.black;
    iconSec = Colors.black54;
    iconAtt = Colors.redAccent;
    iconApp = Colors.lightGreen;

    // 4. Material-colors
    // Circular Progress Indicator
    circPrText = Colors.black;
    circPrIn = primary;
    circPrIn2 = Colors.white38;
    // Card
    cardBck = Colors.white;
    cardInk = Colors.black12;
    cardInkP = primary.withAlpha(20);
    // Divider
    divider = Colors.black38;

    // 5. Special Widget-colors
    dotAc = primary; // Dot-Indicator
    dotIn = secondary; // Other Dots

    // 6. PopUp-colors
    popBack = alternateBackground; // Background
    popText = Colors.white; // Text
    popTextIn = Colors.white54; // Text inactive
    popButton = primary; // Buttons
    popIcon = primary; // Icons
  }

  ThemeData getMaterialTheme() {
    if (darkMode) {
      return ThemeData.dark().copyWith(
        primaryColor: primary,
        accentColor: secondary,
        backgroundColor: standardBackground,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: iconPrimOutline,
        ),
        appBarTheme: AppBarTheme(
          color: primary,
          actionsIconTheme: IconThemeData(color: iconPrimOutline),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(
            color: iconPrimOutline,
          ),
          selectedItemColor: iconPrimOutline,
        ),
        bottomAppBarColor: secondary,
        bottomAppBarTheme: BottomAppBarTheme(
          color: secondary,
        ),
      );
    } else {
      return ThemeData().copyWith(
        primaryColor: primary,
        accentColor: secondary,
        backgroundColor: standardBackground,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: iconPrimOutline,
        ),
        appBarTheme: AppBarTheme(
          color: primary,
          actionsIconTheme: IconThemeData(color: iconPrimOutline),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(
            color: iconPrimOutline,
          ),
          selectedItemColor: iconPrimOutline,
        ),
        bottomAppBarColor: secondary,
        bottomAppBarTheme: BottomAppBarTheme(
          color: secondary,
        ),
      );
    }
  }
}
