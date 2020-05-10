
import '../Design/AppColors.dart';
import 'package:flutter/material.dart';


class NikusScaffold extends StatefulWidget {
  final AppColors appColors;
  final AppBar appBar;
  final Widget child;
  final FloatingActionButton floatingActionButton;
  final _mono;

  NikusScaffold({this.appColors, this.appBar, this.child, this.floatingActionButton})
      : _mono = false;

  NikusScaffold.mono({this.appColors, this.appBar, this.child, this.floatingActionButton})
      : _mono = true;

  @override
  _NikusScaffoldState createState() => _NikusScaffoldState();
}

class _NikusScaffoldState extends State<NikusScaffold> {
  @override
  Widget build(BuildContext context) {
    Scaffold result = Scaffold(
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      body: Container(
        decoration: widget._mono ? null : BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1.0],
            colors: [widget.appColors.grad1, widget.appColors.grad2],
          ),
        ),
        color: widget._mono ? widget.appColors.standardBackground : null,
        child: widget.child,
      ),
    );
    return result;
  }
}