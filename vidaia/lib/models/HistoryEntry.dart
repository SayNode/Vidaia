import 'package:json_annotation/json_annotation.dart';
import 'package:vidaia/models/Product.dart';

part 'HistoryEntry.g.dart';

@JsonSerializable()
class HistoryEntry {
  final Product product;

  final String date;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => _$HistoryEntryFromJson(json);

  HistoryEntry(this.product, this.date);
  Map<String, dynamic> toJson() => _$HistoryEntryToJson(this);
}
