// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BuyHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyHistory _$BuyHistoryFromJson(Map<String, dynamic> json) => BuyHistory(
      json['userId'] as String?,
      (json['history'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList(),
    );

Map<String, dynamic> _$BuyHistoryToJson(BuyHistory instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'history': instance.history,
    };
