import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vidaia/models/Reward.dart';
import 'package:vidaia/utils/constants.dart';
import 'package:vidaia/widgets/roundedButton.dart';

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
        backgroundColor: BACKGROUND,
        drawerEnableOpenDragGesture: false,
        body: Stack(
          children: [
            Expanded(
                child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
              ColorFiltered(
                  colorFilter: ColorFilter.mode(BACKGROUND_SHADE, BlendMode.modulate),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.66,
                      height: MediaQuery.of(context).size.height * 0.33,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), topRight: Radius.circular(50)),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: Padding(
                              padding: EdgeInsets.all(50),
                              child: Image.network(
                                widget.reward.image,
                                fit: BoxFit.fill,
                              ))))),
              Padding(
                  padding: EdgeInsets.only(left: 25, top: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(
                        widget.reward.name,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 25, top: 20),
                        child: Text(
                          "Cost: " + widget.reward.cost.toString(),
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: PRIMARY_LIGHT),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ]),
                    Text(
                      widget.reward.description,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
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
                          onPressed: () {}),
                      SizedBox(
                        width: 20,
                      ),
                      RoundedButton(
                          colour: PRIMARY,
                          width: 20,
                          child: Icon(
                            Icons.info_outlined,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _launchInBrowser(Uri.parse(widget.reward.url));
                          })
                    ]),
                  ])),
            ])),
            Padding(
              padding: EdgeInsets.only(top: 25, left: 15),
              child: IconButton(
                  icon: Center(child: Icon(Icons.arrow_back, color: PRIMARY)),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ));
  }
}
