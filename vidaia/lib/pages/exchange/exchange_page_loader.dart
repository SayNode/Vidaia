import 'package:flutter/material.dart';
import 'package:vidaia/main.dart';
import 'package:vidaia/pages/exchange/exchange_page_stack.dart';
import 'package:vidaia/pages/exchange/receive/recieve_page.dart';
import 'package:vidaia/pages/exchange/send/send_page.dart';
import 'package:vidaia/repositories/dataRepository.dart';

class ExchangePage extends StatefulWidget {
  ExchangePage({Key? key}) : super(key: key);

  @override
  State<ExchangePage> createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  late Future<bool> isDataLoaded;

  DataRepository dataRepository = getIt.get<DataRepository>();

  @override
  void initState() {
    super.initState();
    isDataLoaded = dataRepository.init();
  }

  final _pages = [SendPage(), RecievePage()];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: isDataLoaded,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.data == true) {
            return ExchangePageStack(_pages);
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Loading data",
                    style: TextStyle(color: Colors.black38, fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          }
        });
  }
}
