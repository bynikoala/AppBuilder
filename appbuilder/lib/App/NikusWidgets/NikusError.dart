import 'package:flutter/material.dart';

class NikusError extends StatefulWidget {
  @override
  _NikusErrorState createState() => _NikusErrorState();

  Function _onClick;

  NikusError(this._onClick);


}

class _NikusErrorState extends State<NikusError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Text("Ein Fehler ist aufgetreten. Bitte tippen Sie hier um es erneut zu versuchen.", textAlign: TextAlign.center),
        onTap: widget._onClick,
      ),
    );
  }
}