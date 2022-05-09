import 'package:json_annotation/json_annotation.dart';
import 'package:vidaia/models/Product.dart';

part 'HistoryEntry.g.dart';

@JsonSerializable()
class HistoryEntry {
  final Product product;

  final String date;

  final bool isReceived;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => _$HistoryEntryFromJson(json);

  HistoryEntry(this.product, this.date, this.isReceived);
  Map<String, dynamic> toJson() => _$HistoryEntryToJson(this);
}
