import 'package:flutter/material.dart';
import 'package:vidaia/widgets/vidaia_scaffold.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return VidaiScaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: const Center(child: Text('Welcome User', textScaleFactor: 3, textAlign: TextAlign.center,)),
              color: Colors.grey,
              height: 100,
              width: 200,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: [
                Card(
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blue,
                        Colors.red,
                      ],
                    )),
                  ),
                ),
                Card(
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.yellow,
                        Colors.red,
                      ],
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
