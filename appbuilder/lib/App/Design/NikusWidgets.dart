import 'package:flutter/material.dart';
import 'AppColors.dart';

import 'AppDimensions.dart';

class NikusWidgets {
  Widget viewLoader(AppColors cc, String loadingText, Dimensions spacer) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            backgroundColor: cc.circPrI2,
            valueColor: AlwaysStoppedAnimation<Color>(cc.circPrI),
          ),
          spacer.vSmall(),
          Text(
            loadingText,
            style: TextStyle(color: cc.circPrI),
          ),
        ],
      ),
    );
  }

  Widget getScaffold(AppColors cc, Widget child) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              colors: [cc.grad1, cc.grad2],
            ),
          ),
          child: child,
        ),
    );
  }
}