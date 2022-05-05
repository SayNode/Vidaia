import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color colour;
  final Widget child;
  final double width;
  final VoidCallback onPressed;

  RoundedButton({required this.colour, required this.child, required this.width, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(onPressed: onPressed, minWidth: width, height: 35.0, child: child),
      ),
    );
  }
}
