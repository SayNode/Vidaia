import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:vidaia/models/BuyHistory.dart';
import 'package:vidaia/models/HistoryEntry.dart';
import 'package:vidaia/models/Reward.dart';
import 'package:vidaia/models/Product.dart';
import 'package:vidaia/models/auth0_user.dart';
import 'package:vidaia/services/auth_service.dart';

class DataRepository {
  //can be split up in seperate repositories in the future if needd
  late List<Product> _products;
  late List<Reward> _rewards;
  late BuyHistory _history;
  late Auth0User _userinfo;

  List<Product> get products => _products;
  List<Reward> get rewards => _rewards;
  BuyHistory get history => _history;
  Auth0User get userinfo => _userinfo;

  Future<bool> init() async {
    _products = await loadProducts();
    _rewards = await loadRewards();
    _userinfo = AuthService.instance.profile;
    _history = await loadHistory();
    return true;
  }

  Future<List<Product>> loadProducts() async {
    //read json file
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/products.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;
    //map json and initialize using DataModel
    return list.map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Reward>> loadRewards() async {
    //read json file
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/rewards.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;
    //map json and initialize using DataModel
    return list.map((e) => Reward.fromJson(e)).toList();
  }


  // Future<User> loadUser() async {
  //   //read json file
  //   final jsondata = await rootBundle.rootBundle.loadString('assets/data/user.json');
  //   //decode json data as list
  //   final data = json.decode(jsondata) as dynamic;

  //   return User.fromJson(data);
  // }

  Future<BuyHistory> loadHistory() async {
    //read json file
    final jsondata = await rootBundle.rootBundle.loadString('assets/data/buyHistory.json');
    //decode json data as list
    final data = json.decode(jsondata) as dynamic;

    return BuyHistory.fromJson(data);
  }

  List<HistoryEntry> getReceived() {
    return history.history.where((element) => element.isReceived).toList();
  }

  List<HistoryEntry> getSpent() {
    return history.history.where((element) => !element.isReceived).toList();
  }
}
