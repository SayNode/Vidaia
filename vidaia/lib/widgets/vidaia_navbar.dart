import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../utils/router.gr.dart';

class VidaiaNavBar extends StatelessWidget {
  const VidaiaNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      //shape: shape,
      color: Colors.green,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: SizedBox(
          height: 60,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.home),
                    onPressed: () => {context.router.push(const HomeRoute())},
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () => {context.router.push(const BuyHistoryRoute())},
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.local_offer_outlined),
                    onPressed: () => {context.router.push(const RedeemRoute())},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
