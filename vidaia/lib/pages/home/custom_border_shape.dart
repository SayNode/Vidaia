import 'package:flutter/material.dart';
import 'dart:math' as math;

//padding to the right of vidar in appbar
const double offsetRight = 25;
//change inset to move circle farther into appbar
const double inset = 20;
//change r to change circle size(r is radius)
const double r = 50;

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double oHeight = rect.height - inset;

    //edit this to move the circle
    final oval = Rect.fromCenter(
        center: Offset(rect.width - (r / 2) - offsetRight, oHeight),
        width: r * 2,
        height: r * 2);

    Path path = Path();
    path.lineTo(0, rect.height);
    path.relativeLineTo(rect.width, 0);
    path.relativeLineTo(0, -rect.height);

    double h = oHeight - rect.height + r;
    var alpha = 2 * math.acos(1 - (h / r));

    path.addArc(oval, (math.pi - alpha) / 2, alpha);

    path.close();

    return path;
  }
}
