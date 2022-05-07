import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/models/Product.dart';
import 'package:vidaia/pages/home/home/widgets/new_product_tile.dart';
import 'package:vidaia/repositories/dataRepository.dart';
import 'package:vidaia/utils/constants.dart';

import 'package:vidaia/utils/globals.dart';

import '../../../utils/wallet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataRepository dataRepository = getIt.get<DataRepository>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Row(
              children: [
                Text(
                  'Hi, '.tr(),
                  style: TextStyle(fontSize: 30, color: PRIMARY_DARK, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 3),
                Text(
                  dataRepository.userinfo.displayName,
                  style: TextStyle(fontSize: 30, color: PRIMARY_DARK, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Text(
              'Catchy headline comes here, '.tr(),
              style: TextStyle(fontSize: 18, color: PRIMARY_LIGHT),
              textAlign: TextAlign.center,
            )),
        const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        Container(
          padding: EdgeInsets.only(left: 40, bottom: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'New products'.tr(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.28,
              pageSnapping: false,
              scrollPhysics: PageScrollPhysics(),
              viewportFraction: 0.6,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(seconds: 1),
              enableInfiniteScroll: false,
            ),
            items: getCarrouselItems()),
        ElevatedButton(
            onPressed: () {
              transferVidar(1, '0x00bab3d8de4ebbefb07d53b1ff8c0f2434bd616d', 'https://testnet.veblocks.net');
              print(address);
            },
            child: Text('send 1 vid')),
        ElevatedButton(
            onPressed: () {
              setPriv();
            },
            child: Text('set priv')),

        /*
        StreamBuilder(
          stream: checkBalance(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );

            final balance = snapshot.data.toString();

            return Text(balance);
          },
        ),
        */
      ],
    );
  }

  List<Widget> getCarrouselItems() {
    List<Widget> items = [];
    for (Product prod in dataRepository.products) {
      items.add(NewProductTile(prod));
    }
    return items;
  }
}
