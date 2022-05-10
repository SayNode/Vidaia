import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/models/Product.dart';
import 'package:vidaia/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

class NewProductTile extends StatelessWidget {
  Product prod;

  NewProductTile(this.prod, {Key? key}) : super(key: key);

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
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: Center(
                        child: Image.network(
                      prod.image,
                    ))),
              ),
            ),
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
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prod.name,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Vidar " + prod.tokens.toString(),
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Icon(Icons.arrow_forward,
                                      color: Colors.black),
                                  onPressed: () {
                                    _launchInBrowser(Uri.parse(prod.url));
                                  },
                                ))
                          ]),
                    )))
          ]),
        ));
  }
}
