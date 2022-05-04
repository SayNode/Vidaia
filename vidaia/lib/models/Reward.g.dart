// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reward _$RewardFromJson(Map<String, dynamic> json) => Reward(
      json['name'] as String?,
      json['image'] as String?,
      json['url'] as String?,
      json['cost'] as int?,
      json['description'] as String?,
      json['seller_address'] as String?,
    );

Map<String, dynamic> _$RewardToJson(Reward instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'url': instance.url,
      'cost': instance.cost,
      'description': instance.description,
      'seller_address': instance.seller_address,
    };
