import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../widgets/vidaia_drawer.dart';

//padding to the right of vidar in appbar
const double offsetRight = 25;
//change inset to move circle farther into appbar
const double inset = 20;
//change r to change circle size(r is radius)
const double r = 50;

class HomePageStack extends StatefulWidget {
  final List<Widget> list;

  HomePageStack(this.list);

  @override
  State<HomePageStack> createState() => _HomePageStackState();
}

class _HomePageStackState extends State<HomePageStack> {
  int _selectedIndex = 0;

  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 50),
        child: Stack(children: [
          AppBar(
            shape: CustomShapeBorder(),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: Container(
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
          ),
        ]),
      ),
      drawer: const VidaiaDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined), label: 'Redeem'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.list,
      ),
    );
  }
}

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
