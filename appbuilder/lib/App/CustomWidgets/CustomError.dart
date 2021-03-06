import 'package:flutter/material.dart';

class CustomError extends StatefulWidget {
  @override
  _CustomErrorState createState() => _CustomErrorState();

  final Function _onClick;
  final String error;

  CustomError(this._onClick, {this.error : "Ein Fehler ist aufgetreten. "});


}

class _CustomErrorState extends State<CustomError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Text("${widget.error} Bitte tippen Sie hier um es erneut zu versuchen.", textAlign: TextAlign.center),
        onTap: widget._onClick,
      ),
    );
  }
}
