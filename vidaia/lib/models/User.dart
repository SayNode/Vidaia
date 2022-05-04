import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  final String? userId;

  final String? displayName;

  final String? walletAdress;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User(this.userId, this.displayName, this.walletAdress);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
