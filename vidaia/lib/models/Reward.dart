import 'package:json_annotation/json_annotation.dart';

part 'Reward.g.dart';

@JsonSerializable()
class Reward {
  final String? name;

  final String? image;

  final String? url;

  final int? cost;

  final String? description;

  final String? seller_address;

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  Reward(this.name, this.image, this.url, this.cost, this.description, this.seller_address);
  Map<String, dynamic> toJson() => _$RewardToJson(this);
}
