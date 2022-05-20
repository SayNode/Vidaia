// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoryEntry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryEntry _$HistoryEntryFromJson(Map<String, dynamic> json) => HistoryEntry(
      Product.fromJson(json['product'] as Map<String, dynamic>),
      json['date'] as String,
      json['isReceived'] as bool,
    );

Map<String, dynamic> _$HistoryEntryToJson(HistoryEntry instance) =>
    <String, dynamic>{
      'product': instance.product,
      'date': instance.date,
      'isReceived': instance.isReceived,
    };
