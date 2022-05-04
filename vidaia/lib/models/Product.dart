import 'package:json_annotation/json_annotation.dart';

part 'Product.g.dart';

@JsonSerializable()
class Product {
  final String name;

  final String image;

  final String url;

  final int? tokens;


  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Product(this.name, this.image, this.url, this.tokens);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
