import 'package:flutter/material.dart';
import 'package:vidaia/widgets/vidaia_drawer.dart';
import 'package:vidaia/widgets/vidaia_navbar.dart';
import 'dart:math' as math;

//padding to the right of vidar in appbar
const double offsetRight = 25;
//change inset to move circle farther into appbar
const double inset = 20;
//change r to change circle size(r is radius)
const double r = 50;

class VidaiScaffold extends StatelessWidget {
  final Widget body;

  const VidaiScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Stack(children: [
          AppBar(
            shape: CustomShapeBorder(),

            /*
              Container(
                //height: 80,
                //width: 80,
                margin: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                    color: Colors.orange, shape: BoxShape.circle),
                child: Column(
                  children: const [
                    Expanded(child: Icon(Icons.monetization_on_outlined)),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text("37,37 VID"),
                      ),
                    )
                  ],
                ),
              ),
            */
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: offsetRight - 20 +(r - 80/2)/2),
              child: Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                    color: Colors.orange, shape: BoxShape.circle),
              ),
            ),
          ),
        ]),
      ),
      body: body,
      drawer: const VidaiaDrawer(),
      bottomNavigationBar: const VidaiaNavBar(),
    );
  }
}

/*
class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double innerCircleRadius = 100.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30,
        rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40,
        rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40,
        rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75,
        rect.height + 50);
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30,
        rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}
*/

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double oHeight = rect.height - inset;

    //edit this to move the circle
    final oval = Rect.fromCenter(
        center: Offset(rect.width - (r/2) - offsetRight, oHeight),
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
