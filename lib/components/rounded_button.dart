import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {
  final String title;
  final Color? colour;
  final VoidCallback  onpressed;

  Roundedbutton({this.colour, required this.onpressed,required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Material(
        elevation: 10,
        // color: Colors.amberAccent,
        color: colour,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 100.0,
          height: 42.0,
          child: Text(title,style: TextStyle(color: Colors.white),) ,
        ),
      ),
    );
  }
}
