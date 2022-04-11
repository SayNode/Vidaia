import 'package:flutter/material.dart';
import 'package:vidaia/widgets/vidaia_scaffold.dart';

class RedeemPage extends StatefulWidget {
  const RedeemPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage>
    with SingleTickerProviderStateMixin {
  List<int> items = List.generate(10, (i) => i);
  final ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VidaiScaffold(body: gridViewRedeem());
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<int> newEntries = await requestData(
          items.length, items.length + 10); //returns empty list
      if (newEntries.isEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }

      setState(() {
        items.addAll(newEntries);
        isPerformingRequest = false;
      });
    }
  }

  Widget _loadingNewItemsIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget gridViewRedeem() {
    return GridView.builder(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return _loadingNewItemsIndicator();
        } else {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF0b3b2d),
                      Color(0xFF112823),
                    ],
                  )),
            ),
          );
        }
      },
      //physics: NeverScrollableScrollPhysics(),
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}

Future<List<int>> requestData(int from, int to) async {
  return Future.delayed(const Duration(seconds: 1), () {
    return List.generate(to - from, (i) => i + from);
  });
}
