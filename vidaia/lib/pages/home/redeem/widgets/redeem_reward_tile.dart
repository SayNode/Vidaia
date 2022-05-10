import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/models/Reward.dart';
import 'package:vidaia/pages/home/redeem/redeem_info_page.dart';
import 'package:vidaia/utils/constants.dart';

class RedeemRewardTile extends StatelessWidget {
  Reward reward;

  RedeemRewardTile(this.reward, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
        colorFilter: ColorFilter.mode(BACKGROUND_SHADE, BlendMode.modulate),
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(
                flex: 7,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: Image.network(
                      reward.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
            Expanded(
                flex: 3,
                child: Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Color.fromARGB(169, 94, 160, 124)),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                reward.name,
                                style: Theme.of(context).textTheme.subtitle2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                  child: IconButton(
                                padding: EdgeInsets.all(1),
                                icon: Icon(Icons.arrow_forward,
                                    color: Colors.black),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RedeemInfoPage(reward)),
                                  );
                                },
                              )),
                            )
                          ]),
                    )))
          ]),
        ));
  }
}
