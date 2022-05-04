// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['name'] as String,
      json['image'] as String,
      json['url'] as String,
      json['tokens'] as int?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'url': instance.url,
      'tokens': instance.tokens,
    };
