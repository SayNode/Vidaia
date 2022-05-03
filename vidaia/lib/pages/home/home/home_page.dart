import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../redeem/widgets/redeem_crousel_item.dart';

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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Center(
              child: Text(
                'welcome'.tr() + ' John',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
            height: 100,
            width: 200,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        Container(
          padding: EdgeInsets.only(left: 40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'lastPurchase'.tr(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            pageSnapping: false,
            scrollPhysics: PageScrollPhysics(),
            height: 150,
            viewportFraction: 0.5,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(seconds: 1),
            enableInfiniteScroll: false,
          ),
          items: [
            RedeemCarouselItem(),
            RedeemCarouselItem(),
            RedeemCarouselItem(),
            RedeemCarouselItem(),
          ],
        ),
      ],
    );
  }
}
