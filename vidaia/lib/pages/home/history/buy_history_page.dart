import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/models/HistoryEntry.dart';
import 'package:vidaia/pages/home/history/widgets/history_tile.dart';
import 'package:vidaia/pages/home/home/widgets/new_product_tile.dart';
import 'package:vidaia/repositories/dataRepository.dart';

import '../../../models/Product.dart';
import '../../../utils/constants.dart';

class BuyHistoryPage extends StatefulWidget {
  const BuyHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BuyHistoryPage> createState() => _BuyHistoryPageState();
}

class _BuyHistoryPageState extends State<BuyHistoryPage> with SingleTickerProviderStateMixin {
  late List<HistoryEntry> items = [];
  DataRepository dataRepository = getIt.get<DataRepository>();

  @override
  void initState() {
    super.initState();
    items = dataRepository.history.history;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Container(
        padding: EdgeInsets.only(left: 40, bottom: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(children: [
            Text(
              'History'.tr(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '(Amount:  '.tr() + '${items.length})',
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.left,
              ),
            ),
          ]),
        ),
      ),
      GridView.builder(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return HistoryTile(items[index]);
        },
        //physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 4 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      )
    ]);
  }
}
