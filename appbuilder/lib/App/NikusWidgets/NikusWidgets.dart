import 'package:flutter/material.dart';
import '../Design/AppColors.dart';
import '../Design/AppDimensions.dart';

class NikusWidgets {
  Widget getViewLoader(AppColors ac, String loadingText, AppDimensions ad) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: ac.circPrIn2,
            valueColor: AlwaysStoppedAnimation<Color>(ac.primary),
          ),
          ad.vSmall(),
          Text(
            loadingText,
            style: TextStyle(color: ac.circPrIn),
          ),
        ],
      ),
    );
  }

  Widget getScaffold({AppColors AppColors, Widget child, FloatingActionButton FloatingActionButton}) {
    return Scaffold(
      floatingActionButton: FloatingActionButton,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1.0],
            colors: [AppColors.grad1, AppColors.grad2],
          ),
        ),
        child: child,
      ),
    );
  }
}
