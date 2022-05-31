import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidaia/models/Reward.dart';
import 'package:vidaia/utils/constants.dart';
import 'package:vidaia/widgets/roundedButton.dart';
import 'package:vidaia/utils/wallet.dart';
import '../../../utils/exceptions.dart';
import '../../../utils/popups.dart';


class RedeemInfoPage extends StatefulWidget {
  final Reward reward;

  RedeemInfoPage(this.reward);

  @override
  State<RedeemInfoPage> createState() => _RedeemInfoPageState();
}

class _RedeemInfoPageState extends State<RedeemInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: BACKGROUND,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: BACKGROUND,
        drawerEnableOpenDragGesture: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Stack(
              children: [
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              BACKGROUND_SHADE, BlendMode.modulate),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.66,
                              height: MediaQuery.of(context).size.height * 0.33,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(50),
                                    topRight: Radius.circular(50)),
                                color: Colors.white,
                              ),
                              child: Center(
                                  child: Padding(
                                      padding: EdgeInsets.all(40),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            widget.reward.image,
                                            fit: BoxFit.fill,
                                          )))))),
                      Padding(
                          padding: EdgeInsets.only(left: 25, top: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.reward.name,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: 25, top: 20),
                                        child: Text(
                                          "Cost: " +
                                              widget.reward.cost.toString(),
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                              color: PRIMARY_LIGHT),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]),
                                Container(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    widget.reward.description,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Row(children: [
                                  RoundedButton(
                                      colour: BUTTON,
                                      width: 50,
                                      child: Text(
                                        "Buy now",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onPressed: () async {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        await fetchOffers(context);
                                        /*
                                        transferVidar(
                                            widget.reward.cost,
                                            '0x00bab3d8de4ebbefb07d53b1ff8c0f2434bd616d',
                                            'https://testnet.veblocks.net');
                                            */
                                      }),
                                  SizedBox(
                                    width: 20,
                                  ),

                                  /*
                                  IconButton(onPressed: () {
                                        _launchInBrowser(
                                            Uri.parse(widget.reward.url));
                                      }, icon: Icon(
                                        Icons.info_outlined,
                                        color: Colors.black,
                                      )),
                                      */
                                  RoundedButton(
                                      colour: PRIMARY,
                                      width: 20,
                                      child: Text(
                                        'More Information',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        _launchInBrowser(
                                            Uri.parse(widget.reward.url));
                                      })
                                ]),
                              ])),
                    ])),
                /*
                Padding(
                  padding: EdgeInsets.only(top: 25, left: 15),
                  child: IconButton(
                      icon: Center(child: Icon(Icons.arrow_back, color: PRIMARY)),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
                */
              ],
            ),
          ),
        ));
  }

  Future fetchOffers(BuildContext context) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.75),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text(
                    'Confirm purchase',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'click button bellow to confirm purchase',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: BUTTON,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Theme(
                      data: ThemeData.light(),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8),
                        title: Text(
                          widget.reward.name,
                          style: TextStyle(fontSize: 18, color: PRIMARY),
                        ),
                        trailing: Text(
                          widget.reward.cost.toString() + ' VID',
                          style: TextStyle(fontSize: 16, color: PRIMARY),
                        ),
                        onTap: () async {
                          onLoading(context);
                          late Map res;
                          try {
                            res = await transferVidar(
                                widget.reward.cost,
                                '0x00bab3d8de4ebbefb07d53b1ff8c0f2434bd616d',
                                'https://testnet.veblocks.net');
                                
                          } on InvalidAddressException {
                            oneButtonPopup(context, Text('Transaction Failed'),
                                Text('The Address is not valid'));
                          } finally {
                            if (res.containsKey('id')) {
                              Navigator.pop(context);
                              confirmPurchase(context);
                            } else {
                              Navigator.pop(context);
                              txError(context);
                            }
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
