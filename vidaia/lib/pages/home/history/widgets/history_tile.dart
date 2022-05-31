import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/models/HistoryEntry.dart';
import 'package:vidaia/repositories/dataRepository.dart';
import 'package:vidaia/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryTile extends StatelessWidget {
  HistoryEntry item;
  bool isReceived;
  DataRepository dataRepository = getIt.get<DataRepository>();

  HistoryTile(this.item, this.isReceived, {Key? key}) : super(key: key);

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
            child: Stack(children: [
              Row(children: [
                Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2, left: 10),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 5,
                        child: Center(
                            child: Image.network(
                          item.product.image,
                          fit: BoxFit.contain,
                        )))),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                    ),
                    child: Container(),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            color: isReceived
                                ? Color.fromARGB(169, 94, 160, 124)
                                : BUTTON),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Vidar " +
                                                  item.product.tokens
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            Text(
                                              item.date.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                            SizedBox(),
                                          ]),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: IconButton(
                                      icon: Icon(Icons.arrow_forward,
                                          color: Colors.black),
                                      onPressed: () {
                                        _launchInBrowser(
                                            Uri.parse(item.product.url));
                                      },
                                    ))
                              ]),
                        )))
              ]),
            ])));
  }
}
