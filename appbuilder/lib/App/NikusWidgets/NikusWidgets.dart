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
}
