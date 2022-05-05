import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/models/Reward.dart';
import 'package:vidaia/pages/home/redeem/widgets/redeem_reward_tile.dart';
import 'package:vidaia/repositories/dataRepository.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> with SingleTickerProviderStateMixin {
  DataRepository dataRepository = getIt.get<DataRepository>();

  late List<Reward> items = [];
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();
    items = dataRepository.rewards;
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
          child: Text(
            'Rewards'.tr(),
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.left,
          ),
        ),
      ),
      GridView.builder(
        primary: false,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return RedeemRewardTile(items[index]);
        },
        //physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      )
    ]);
  }
}
