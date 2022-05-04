import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vidaia/models/Product.dart';

part 'BuyHistory.g.dart';

@JsonSerializable()
class BuyHistory {
  final String? userId;

  final List<Map<dynamic, String>>? history;

  factory BuyHistory.fromJson(Map<String, dynamic> json) => _$BuyHistoryFromJson(json);

  BuyHistory(this.userId, this.history);
  Map<String, dynamic> toJson() => _$BuyHistoryToJson(this);
}
