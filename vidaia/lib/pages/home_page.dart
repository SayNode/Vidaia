import 'package:flutter/material.dart';
import 'package:vidaia/widgets/vidaia_scaffold.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/vidaia_carousell_item.dart';

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
              child: Center(
                child: Text(
                  'Welcome User',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              height: 100,
              width: 200,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              options: CarouselOptions(
                  autoPlay: false,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false),
              items: [
                VidaiaCarouselItem(),
                VidaiaCarouselItem(),
                VidaiaCarouselItem(),
                VidaiaCarouselItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
