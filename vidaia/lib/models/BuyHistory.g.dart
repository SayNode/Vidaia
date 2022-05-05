// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BuyHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyHistory _$BuyHistoryFromJson(Map<String, dynamic> json) => BuyHistory(
      json['userId'] as String,
      (json['history'] as List<dynamic>)
          .map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuyHistoryToJson(BuyHistory instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'history': instance.history,
    };
