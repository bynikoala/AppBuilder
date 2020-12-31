
import '../Design/AppColors.dart';
import 'package:flutter/material.dart';


class CustomScaffold extends StatefulWidget {
  final AppColors appColors;
  final AppBar appBar;
  final Widget child;
  final FloatingActionButton floatingActionButton;
  final BottomNavigationBar bottomNavigationBar;
  final _mono;

  CustomScaffold({this.appColors, this.appBar, this.child, this.floatingActionButton, this.bottomNavigationBar})
      : _mono = false;

  CustomScaffold.mono({this.appColors, this.appBar, this.child, this.floatingActionButton, this.bottomNavigationBar})
      : _mono = true;

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    Scaffold result = Scaffold(
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      bottomNavigationBar: widget.bottomNavigationBar,
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